## Installation, the short version
The short version is, to install the OpenLane environment...

> On Windows, install and launch the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install) before doing anything. We recommend and provide instructions for Ubuntu 20.04.

> On macOS, get [brew](https://brew.sh).

1. [Get Docker](https://docs.docker.com/get-docker/) (or a compatible container engine)
    * On Ubuntu, follow the [Docker post install instructions](https://docs.docker.com/engine/install/linux-postinstall/) after you install Docker.
2. Get Python 3.6 or higher ([macOS](https://formulae.brew.sh/formula/python3) | [Ubuntu](https://packages.ubuntu.com/focal/python3))
    * On Ubuntu, you may also need to install venv: `apt-get install python3-venv`, and pip: `apt-get install python3-pip`.
3. Get git ([macOS](https://formulae.brew.sh/formula/git) | [Ubuntu](https://packages.ubuntu.com/focal/git))
4. Get GNU Make ([macOS](https://formulae.brew.sh/formula/make) | [Ubuntu](https://packages.ubuntu.com/focal/make))


Run the following commands in your command-line prompt:

```sh
cd $HOME
git clone https://github.com/RustamC/OpenLane.git
cd OpenLane
git switch dreamplace
git branch working_dream 71d6c6e
git checkout working_dream
make openlane BUILD_IF_CANT_PULL=1
make pdk
make test
```

If everything's gone smoothly, that's it. OpenLane with DREAMPlace support is set up on your computer. To enter the OpenLane environment, `cd $HOME/OpenLane` and then `make mount`.

## Running DREAMPlace instead of RePlAce at global placement
In the current version one can use DREAMPlace only at global placement as the placer is not stable enough at detailed placement and legalization.

To enable DREAMPlace just add to config.json one variable:
```json
{
  ...
  "PL_DREAMPLACE_GLB_PLACEMENT": true
  ...
}
```
