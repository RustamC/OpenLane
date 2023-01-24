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

read_verilog $::env(synthesis_results)/$::env(DESIGN_NAME).v

foreach lib $::env(LIB_SYNTH_COMPLETE) {
    read_liberty $lib
}

if { [info exists ::env(EXTRA_LIBS) ] } {
    foreach lib $::env(EXTRA_LIBS) {
        read_liberty $lib
    }
}

if {[catch {read_lef $::env(MERGED_LEF)} errmsg]} {
    puts stderr $errmsg
    exit 1
}

if { ![info exits $::env(SYNTH_NUM_PARTITIONS)] } {
	puts stderr "Number of partitions is not set! (SYNTH_NUM_PARTITIONS)"
	exit 1
}

link_design $::env(DESIGN_NAME)

puts stdout "Start partitioning"
set id [partition_netlist -tool mlpart -num_partitions $::env(SYNTH_NUM_PARTITIONS) -num_starts 100]
set id [partition_netlist -tool mlpart -num_partitions $::env(SYNTH_NUM_PARTITIONS) -num_starts 100 -partition_id $id]
set id [partition_netlist -tool mlpart -num_partitions $::env(SYNTH_NUM_PARTITIONS) -num_starts 100 -partition_id $id]

puts stdout "Writing partitioning"
set v_file $::env(synthesis_results)/$::env(DESIGN_NAME).part.v

puts stdout "write_partition_verilog -partitioning_id $id $v_file"
write_partition_verilog -partitioning_id $id $v_file
