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

import sys
import json
import click

config_file = sys.argv[1]
def_in_file = sys.argv[2]
lef_in_file = sys.argv[3]
def_out_file = sys.argv[4]
result_dir = sys.argv[5]
target_density = float(sys.argv[6])
global_flag = int(sys.argv[7])
legalize_flag = int(sys.argv[8])
detailed_flag = int(sys.argv[9])

config_file_writer = open(config_file, "w")

json_dict = {
    "def_input" : def_in_file, 
    "lef_input" : lef_in_file,
    "gpu" : 0,
    "num_bins_x" : 0,
    "num_bins_y" : 0,
    "global_place_stages" : [
        {
            "iteration" : 1000, 
            "learning_rate" : 0.01, 
            "wirelength" : "weighted_average", 
            "optimizer" : "nesterov"
        }
    ],
    "target_density" : target_density,
    "density_weight" : 8e-5,
    "gamma" : 4,
    "random_seed" : 1000,
    "ignore_net_degree" : 100,
    "enable_fillers" : 1,
    "gp_noise_ratio" : 0.025,
    "global_place_flag" : global_flag,
    "legalize_flag" : legalize_flag,
    "detailed_place_flag" : detailed_flag,
    "detailed_place_engine" : "",
    "detailed_place_command" : "",
    "stop_overflow" : 0.1,
    "result_dir" : result_dir,
    "dtype" : "float32",
    "plot_flag" : 0,
    "random_center_init_flag" : 1,
    "sort_nets_by_degree" : 0,
    "num_threads" : 4,
    "deterministic_flag" : 0,
    "routability_opt_flag" : 0,
    "RePlAce_UPPER_PCOF" : 1.05
}

json.dump(json_dict, config_file_writer, indent=4)

config_file_writer.close()
