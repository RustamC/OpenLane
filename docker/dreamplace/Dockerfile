# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# syntax = docker/dockerfile:1.0-experimental
ARG RUN_BASE_IMAGE=
ARG BUILD_BASE_IMAGE=

FROM pytorch/manylinux-cuda:111
FROM ${BUILD_BASE_IMAGE} AS builder

#FROM pytorch/manylinux-cuda:111

# git clone dreamplace
ARG DREAMPLACE_REPO
ARG DREAMPLACE_COMMIT

WORKDIR /dreamplace

RUN yum -y install wget flex boost169-devel cairo-devel bison libjpeg-devel python3-devel

ADD https://cmake.org/files/v3.21/cmake-3.21.0-linux-x86_64.sh /cmake-3.21.0-linux-x86_64.sh
RUN mkdir /opt/cmake \
        && sh /cmake-3.21.0-linux-x86_64.sh --prefix=/opt/cmake --skip-license \
        && ln -sfn /opt/cmake/bin/cmake /usr/local/bin/cmake \
        && cmake --version

ADD https://ftp.gnu.org/gnu/bison/bison-3.3.2.tar.gz /bison-3.3.2.tar.gz 
RUN tar -xf /bison-3.3.2.tar.gz &&\
        cd bison-3.3.2 &&\
        ./configure --prefix=/opt/bison &&\
        make &&\
        make install

WORKDIR /dreamplace
RUN pip3 install \
        pyunpack>=0.1.2 \
        patool>=1.12 \
        matplotlib>=2.2.2 \
        cairocffi>=0.9.0 \
        pkgconfig>=1.4.0 \
        setuptools>=39.1.0 \
        scipy>=1.1.0 \
        numpy>=1.15.4 \
        shapely>=1.7.0 \
        torch>=1.6

RUN git clone https://github.com/limbo018/DREAMPlace.git &&\
    cd DREAMPlace &&\
    git fetch &&\
    git checkout -b develop origin/develop &&\
    git submodule init &&\
    git submodule update &&\
    mkdir build &&\
    cd build &&\
    cmake .. -DCMAKE_INSTALL_PREFIX=/build -DPYTHON_EXECUTABLE=$(which python3) -DBOOST_INCLUDEDIR=/usr/include/boost169/ -DBOOST_LIBRARYDIR=/usr/lib64/boost169/ -DBISON_EXECUTABLE=/opt/bison/bin/bison &&\
    make &&\
    make install

WORKDIR /dreamplace
RUN mkdir -p /build/version
RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/dreamplace.version
RUN echo ${DREAMPLACE_COMMIT} >> /build/version/dreamplace.version
RUN tar -czf /build.tar.gz /build

# ---
FROM ${RUN_BASE_IMAGE} AS runnable
ENV PATH /build/bin:$PATH

COPY --from=builder /build /build
COPY --from=builder /build.tar.gz /build.tar.gz
