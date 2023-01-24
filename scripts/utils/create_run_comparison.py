#!/usr/bin/env python3
import os
import csv
import argparse
from operator import itemgetter

def subdict(d, ks):
    return dict(zip(ks, itemgetter(*ks)(d)))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog = 'create_run_comparison')
    parser.add_argument('directory')

    args = parser.parse_args()

    rootdir = os.path.abspath(args.directory)
    result_file = rootdir + '/' + 'result.csv'

    #print("rootdir = " + rootdir)
    #print("result_file = " + result_file)

    with open(result_file, 'w', newline='') as result_csv:
        fieldnames = ['design_name', 'config', 'wire_length', 'vias', 'critical_path_ns', 'power_typical_internal_uW', 'power_typical_switching_uW', 'power_typical_leakage_uW']
        #fieldnames = ['design_name', 'config', 'wns']
        out = csv.DictWriter(result_csv, quoting=csv.QUOTE_NONE, fieldnames=fieldnames, dialect='excel')

        out.writeheader()

        for subdir, dirs, files in os.walk(rootdir):
            dirname = os.path.basename(subdir)
            if dirname == "issue_reproducible" or dirname != "reports":
                continue
            #print('subdir: ' + subdir)

            for file in files:
                if file == "metrics.csv":
                    inp = subdir + '/' + file
                    print('\t' + inp)
                    with open(inp, 'r', newline='') as csvfile:
                        reader = csv.DictReader(csvfile, delimiter=',')
                         
                        for row in reader:
                            s = subdict(row, fieldnames)
                            print(s)
                            out.writerow(s)
