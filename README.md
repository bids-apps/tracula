## [WIP] TRACULA BIDS App
[![CircleCI](https://circleci.com/gh/BIDS-Apps/tracula.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/BIDS-Apps/tracula)
### Description
This app implements [Freesurfer's](https://surfer.nmr.mgh.harvard.edu/)
[TRACULA ](https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula)
(TRActs Constrained by UnderLying Anatomy) tool for
cross-sectional as well as longitudinal (multi session) input data.

### Disclaimer
This BIDS-App was tested with [high-angular resolution
diffusion weighted imaging (DWI) data without
fieldmaps](https://openfmri.org/dataset/ds000114/).
If you would like to see it working with more complex data,
[get in touch](https://github.com/bids-apps/tracula/issues).


### How to report errors
For Tracula-BIDS-Apps related problems, open an
[issue](https://github.com/bids-apps/tracula/issues).

For Tracula-relade errors contact the
[Freesurfer mailing list](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSupport).



### Acknowledgements
https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferMethodsCitation

##

### Analysis levels

- **participant**: Tract reconstruction

    Performs the three steps (prep, bedp, path) of Tracula's `trac-all`,
    reconstructing major fiber tracts form Freesurfer outputs and
    DWI raw data.
    All data is written into *<output_dir>*.

- **group1**: Motion statistics

    Collects motion statistics for multiple subjects into one file.
    Additionally, total motion index (TMI, according to
    [Yendiki et al., 2013](http://doi.org/10.1016/j.neuroimage.2013.11.027)).
    Output is written to
    *<output_dir>/00_group1_motion_stats/group_motion.tsv*.

    *Note*: In deviation to the original equation
    (which includes rotation, translation, bad slices, dropout score),
    this implementation of TMI only considers those measures
    that show enought variance for normalization (i.e., don't
    produce NaNs - often seen in 'PercentBadSlices' and
    'AvgDropoutScore'). The measures that went into the
    calculation can be found in the *TMI_info* column of the
    output file.

- **group2**: Overall tract statistics

    Collects characteristics of a tract (average FA...)
    for multiple subjects.
    Output is written to
    *<output_dir>/00_group2_tract_stats/<tract_name>_stats.tsv*.


### Usage
This App has the following command line arguments:

        usage: phys.py [-h] --license_key LICENSE_KEY
                       [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL ...]]
                       [--freesurfer_dir FREESURFER_DIR]
                       [--stages {prep,bedp,path,all} [{prep,bedp,path,all} ...]] [-v]
                       bids_dir output_dir {participant,group1,group2}

        BIDS App for Tracula processing stream.
        https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula

        positional arguments:
          bids_dir              The directory with the input dataset formatted
                                according to the BIDS standard.
          output_dir            The directory where the output files should be stored.
                                If you are running group level analysis this folder
                                should be prepopulated with the results of
                                theparticipant level analysis.
          {participant,group1,group2}
                                Level of the analysis that will be performed.
                                "participant": reconstructs paths (trac-all -prep,
                                -bedp and -path), "group1": collects motion stats in
                                one file, "group2": collects single subject overall
                                path stats in one file.

        optional arguments:
          -h, --help            show this help message and exit
          --license_key LICENSE_KEY
                                FreeSurfer license key - letters and numbers after "*"
                                in the email you received after registration. To
                                register (for free) visit
                                https://surfer.nmr.mgh.harvard.edu/registration.html
                                (default: None)
          --participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL ...]
                                The label of the participant that should be analyzed.
                                The label corresponds to sub-<participant_label> from
                                the BIDS spec (so it does not include "sub-"). If this
                                parameter is not provided all subjects should be
                                analyzed. Multiple participants can be specified with
                                a space separated list. (default: None)
          --freesurfer_dir FREESURFER_DIR
                                The directory with the freesurfer data. If not
                                specified, output_dir is assumed to be populated with
                                freesurfer data. (default: None)
          --stages {prep,bedp,path,all} [{prep,bedp,path,all} ...]
                                Participant-level trac-all stages to run. Passing "all" will
                                run "prep", "bedp" and "path". (default: ['all'])
          -v, --version         show program's version number and exit



##
### Examples
To run it in participant level mode (for one participant):
#### Participant level

        docker run -ti --rm \
         -v /data/ds114/sourcedata:/bids_dataset:ro \
         -v /data/ds114/derivates/tracula:/outputs \
         -v /data/ds114/derivates/freesurfer:/freesurfer \
         bids/tracula \
         /bids_dataset /outputs participant --participant_label 01 \
         --license_key "XXXXXXXX" \
         --freesurfer_dir /freesurfer

**Note that** the path specified in --freesurfer_dir needs to be the
mount point inside the docker container (e.g., */freesurfer*, specified
in the 4th line of the previous command, after the ":"), not the
path on your hard drive (e.g., */data/ds114/derivates/freesurfer*)

#### Group level

After doing this for all subjects (potentially in parallel) the group level analysis
can be run.

To aggregate motion statistics into one file (group1 stage), run:

        docker run -ti --rm \
         -v /data/ds114/sourcedata:/bids_dataset:ro \
         -v /data/ds114/derivates/tracula:/outputs \
         -v /data/ds114/derivates/freesurfer:/freesurfer \
         bids/tracula \
         /bids_dataset /outputs group1 \
         --license_key "XXXXXXXX" \
         --freesurfer_dir /freesurfer



To collect single subject overall path stats in one file (group2 stage), run:

        docker run -ti --rm \
         -v /data/ds114/sourcedata:/bids_dataset:ro \
         -v /data/ds114/derivates/tracula:/outputs \
         -v /data/ds114/derivates/freesurfer:/freesurfer \
         bids/tracula \
         /bids_dataset /outputs group2 \
         --license_key "XXXXXXXX" \
         --freesurfer_dir /freesurfer
