# Copyright 2020-2022 Efabless Corporation
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

source $::env(SCRIPTS_DIR)/openroad/common/io.tcl
read

set ::block [[[::ord::get_db] getChip] getBlock]
set ::insts [$::block getInsts]

set placement_needed 0

foreach inst $::insts {
	if { ![$inst isFixed] } {
		set placement_needed 1
		break
	}
}

if { !$placement_needed } {
	puts "\[WARN] All instances are FIXED/FIRM."
	puts "\[WARN] No need to perform global placement."
	puts "\[WARN] Skipping..."
	write
	exit 0
}

set json_conf "$::env(DESIGN_DIR)/dreamplace.json"
file copy -force $::env(CURRENT_DEF) $::env(SAVE_DEF)

set json_gen_cmd "python3 $::env(SCRIPTS_DIR)/config/dreamplace_conf.py \
	$json_conf \
	$::env(SAVE_DEF) \
	$::env(MERGED_LEF) \
	$::env(SAVE_DEF) \
	$::env(placement_tmpfiles) \
	$::env(PL_TARGET_DENSITY)"

if { [catch {exec {*}$json_gen_cmd} errmsg] } {
    puts stderr $errmsg
    exit -1
}

set dreamplace_cmd "python3 $::env(DREAMPLACE_BIN) $json_conf"
puts "\[INFO\] DREAMPLACE: $dreamplace_cmd"

set status [catch {exec {*}$dreamplace_cmd} errmsg]

switch status {
	0 {
		puts "\[INFO\] DREAMPlace finished successfully!"
	}
	1 {
		puts stderr "\[WARN\] Check DREAMPlace, please: $dreamplace_cmd"
	}
	default {
		puts stderr $errmsg
    	# exit -1
	}
}

if {1} {
	# to disable this tcl code
	# instead of /build/dreamplace/Placer.py:52
	# path = "%s" % (params.result_dir)
	# instead of /build/dreamplace/Placer.py:57
	#         "%s.%s" % (params.design_name(), params.solution_file_suffix()))
	set save_def_basename [file rootname [file tail $::env(SAVE_DEF)]]
	set out_def_name "$::env(placement_tmpfiles)/$save_def_basename/$save_def_basename.gp.def"
	puts "\[INFO\] Out: $out_def_name"
	file copy -force $out_def_name $::env(SAVE_DEF)
} 

## Standard part starts
if {1} {
	if {[catch {read_def $::env(SAVE_DEF)} errmsg]} {
		puts stderr $errmsg
		exit 1
	}

	if { $::env(PL_TIME_DRIVEN) } {
		source $::env(SCRIPTS_DIR)/openroad/common/set_rc.tcl
		# read_sdc $::env(CURRENT_SDC)
	}

	if { $::env(PL_ROUTABILITY_DRIVEN) } {
		source $::env(SCRIPTS_DIR)/openroad/common/set_routing_layers.tcl
		set_macro_extension $::env(GRT_MACRO_EXTENSION)
		source $::env(SCRIPTS_DIR)/openroad/common/set_layer_adjustments.tcl
	}

	if {[info exists ::env(CLOCK_PORT)]} {
		if { $::env(PL_ESTIMATE_PARASITICS) == 1 } {
			#read_sdc -echo $::env(CURRENT_SDC)
			unset_propagated_clock [all_clocks]
			# set rc values
			source $::env(SCRIPTS_DIR)/openroad/common/set_rc.tcl
			estimate_parasitics -placement

			set ::env(RUN_STANDALONE) 0
			source $::env(SCRIPTS_DIR)/openroad/sta.tcl
		}
	} else {
		puts "\[WARN\]: No CLOCK_PORT found. Skipping STA..."
	}
}
