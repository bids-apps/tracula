## [WIP] TRACULA BIDS App
[![CircleCI](https://circleci.com/gh/BIDS-Apps/tracula.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/BIDS-Apps/tracula)
### Description
This app implements [Freesurfer's](https://surfer.nmr.mgh.harvard.edu/)
[TRACULA ](https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula)
(TRActs Constrained by UnderLying Anatomy) tool for
sectional as well as longitudinal (multi session) input data.

### Disclaimer
This BIDS-App was tested with standard DWI data (without fieldmaps).
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
- participant: tract reconstruction
- group1: motion stats
- group2: overall tract stats

### Usage
This App has the following command line arguments:

        XXX
        XXX


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