import sys
import csv
import subprocess
import argparse
import os
from datetime import datetime
import inspect

parser = argparse.ArgumentParser(description='Run batch of proefsleufisimulaties')
parser.add_argument(
                    '-i',
                    metavar='inputfile',
                    type=str,
                    help='Path to csv file containing input parameters',
                    dest='inputfile',
                    required=True
                   )

parser.add_argument(
                    '-o',
                    metavar='ouputfolder',
                    type=str,
                    help='Path to outputfolder',
                    dest='outputfolder',
                    required=True
                   )

args = parser.parse_args()

outputfile = os.path.join(args.outputfolder, datetime.now().isoformat().replace(':', '-') + '_batch_result.csv')
with open(outputfile, 'wb') as outputfile:
    fieldnames = [
                  "OBJECTID",
                  "RUN",
                  "TRENCH_AREA",
                  "TRENCH_P",
                  "ROTATION",
                  "MID_X",
                  "MID_Y",
                  "F_INT",
                  "A_INT",
                  "F_INT_P",
                  "A_INT_P",
                  "N_INT",
                  "N_INT_R",
                  "M_CONF",
                  "M_L",
                  "M_I",
                  "M_D",
                  "M_W",
                  "M_C",
                  "M_PLAN",
                  "M_EXTENT",
                  "M_AREA_AN",
                  "M_AREA_EX",
                  "M_L_AN",
                  "M_W_AN",
                  "M_X_MIN",
                  "M_Y_MIN",
                  "M_X_MAX",
                  "M_Y_MAX",
                  "M_F_AN",
                 ]
    writer = csv.DictWriter(outputfile, fieldnames=fieldnames)
    writer.writeheader()

    with open(args.inputfile, 'rb') as f:
        jobs = csv.DictReader(f)
        for job in jobs:
            subprocess.call([
                             sys.executable,
                             os.path.join(os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))), 'proefsleufsimulaties.py'),
                             job['workspace'],
                             job['opgravingsplan'],
                             job['gebiedsbegrenzing'],
                             job['veldnaam_voor_analyse'],
                             job['bepaling_middelpunt'],
                             job['middelpunt_x'],
                             job['middelpunt_y'],
                             job['bepaling_draaihoek'],
                             job['draaihoek'],
                             job['sleuflengte'],
                             job['interval'],
                             job['afstand'],
                             job['breedte'],
                             job['configuratie'],
                             job['aantal_simulaties'],
                             '.csv'
                            ])

            with open(os.path.join(
                                   job['workspace'], 
                                   job['configuratie'], 
                                   'L%s_I%s_D%s_W%s_%sSims' % (float(job['sleuflengte']), float(job['interval']), float(job['afstand']), float(job['breedte']), job['aantal_simulaties']),
                                   'SimResult.csv'), 'rb') as r:
                 results = csv.DictReader(r)
                 for result in results:
                     writer.writerow(result)
