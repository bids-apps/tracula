#!/usr/bin/env python3
import argparse
import os

from bids.grabbids import BIDSLayout

from tracula import run_cmd, participant_level, group_level_motion_stats, group_level_tract_overall_stats

__version__ = open('/version').read()

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter,
                                 description='BIDS App for  Tracula processing stream. '
                                             'https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula')
parser.add_argument('bids_dir', help='The directory with the input dataset '
                                     'formatted according to the BIDS standard.')
parser.add_argument('output_dir', help='The directory where the output files '
                                       'should be stored. If you are running group level analysis '
                                       'this folder should be prepopulated with the results of the'
                                       'participant level analysis.')
parser.add_argument('analysis_level', help='Level of the analysis that will be performed. '
                                           '"participant": reconstructs paths (trac-all -prep, -bedp and -path), '
                                           '"group1": collects motion stats in one file, '
                                           '"group2": collects single subject overall path stats in one file.',
                    choices=['participant', 'group1', 'group2'])
parser.add_argument('--license_key', help='FreeSurfer license key - letters and numbers after "*" in the email '
                                          'you received after registration. To register (for free) visit '
                                          'https://surfer.nmr.mgh.harvard.edu/registration.html', required=True)
parser.add_argument('--participant_label',
                    help='The label of the participant that should be analyzed. The label '
                         'corresponds to sub-<participant_label> from the BIDS spec '
                         '(so it does not include "sub-"). If this parameter is not '
                         'provided all subjects should be analyzed. Multiple '
                         'participants can be specified with a space separated list.', nargs="+")
parser.add_argument('--session_label',
                    help='The label of the sessions that should be analyzed. The label '
                         'corresponds to ses-<session_label> from the BIDS spec '
                         '(so it does not include "ses-"). If this parameter is not '
                         'provided all sessions should be analyzed. Multiple '
                         'sessions can be specified with a space separated list.', nargs="+")

parser.add_argument('--freesurfer_dir', help='The directory with the freesurfer data. If not specified, '
                                             'output_dir is assumed to be populated with freesurfer data.')
parser.add_argument('--stages', help='Participant-level trac-all stages to run. Passing'
                                     '"all" will run "prep", "bedp" and "path". ',
                    choices=["prep", "bedp", "path", "all"], default=["all"], nargs="+")
parser.add_argument('--n_cpus', help='Number of CPUs/cores available to use.', default=1, type=int)
parser.add_argument('--run-freesurfer-tests-only', help='Dev option to enable freesurfer tests on circleci',
                    dest="run_freesurfer_tests_only", action='store_true', default=False)
parser.add_argument('-v', '--version', action='version',
                    version='Tracula BIDS-App version {}'.format(__version__))




args = parser.parse_args()

####
if not args.freesurfer_dir:
    args.freesurfer_dir = args.output_dir

# check output dir exists or create
if not os.path.exists(args.output_dir):
    os.makedirs(args.output_dir)

run_cmd("bids-validator " + args.bids_dir)

layout = BIDSLayout(args.bids_dir)

if args.participant_label:
    subjects_to_analyze = args.participant_label
else:
    subjects_to_analyze = layout.get_subjects()

if args.analysis_level == "participant":
    participant_level(args, layout, subjects_to_analyze, args.session_label)

elif args.analysis_level == "group1":
    group_level_motion_stats(args, subjects_to_analyze)

elif args.analysis_level == "group2":
    group_level_tract_overall_stats(args, subjects_to_analyze)
