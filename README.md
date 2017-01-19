## [WIP] TRACULA BIDS App
[![CircleCI](https://circleci.com/gh/BIDS-Apps/tracula.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/BIDS-Apps/tracula)
### Description
This app implements [Freesurfer's](https://surfer.nmr.mgh.harvard.edu/)
[TRACULA ](https://surfer.nmr.mgh.harvard.edu/fswiki/Tracula)
(TRActs Constrained by UnderLying Anatomy) tool.

It takes cross sectional as well as longitudinal (multi session)
input data.

### How to report errors
https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSupport

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

To run it in participant level mode (for one participant):

        docker run -ti --rm \
        XXXXX

After doing this for all subjects (potentially in parallel) the group level analysis
can be run:

        docker run -ti --rm \
        XXX



