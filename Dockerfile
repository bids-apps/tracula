FROM bids/base_fsl


#### FreeSurfer
RUN apt-get -y update && \
    wget -qO- https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz | tar zxv -C /opt \
    --exclude='freesurfer/subjects/fsaverage_sym' \
    --exclude='freesurfer/subjects/fsaverage3' \
    --exclude='freesurfer/subjects/fsaverage4' \
    --exclude='freesurfer/subjects/fsaverage5' \
    --exclude='freesurfer/subjects/fsaverage6' \
    --exclude='freesurfer/subjects/cvs_avg35' \
    --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
    --exclude='freesurfer/subjects/bert' \
    --exclude='freesurfer/subjects/V1_average' \
    --exclude='freesurfer/average/mult-comp-cor' \
    --exclude='freesurfer/lib/cuda' \
    --exclude='freesurfer/lib/qt'

# Set up the environment
ENV OS=Linux
ENV FS_OVERRIDE=0
ENV FIX_VERTEX_AREA=
ENV SUBJECTS_DIR=/opt/freesurfer/subjects
ENV FSF_OUTPUT_FORMAT=nii.gz
ENV MNI_DIR=/opt/freesurfer/mni
ENV LOCAL_DIR=/opt/freesurfer/local
ENV FREESURFER_HOME=/opt/freesurfer
ENV FSFAST_HOME=/opt/freesurfer/fsfast
ENV MINC_BIN_DIR=/opt/freesurfer/mni/bin
ENV MINC_LIB_DIR=/opt/freesurfer/mni/lib
ENV MNI_DATAPATH=/opt/freesurfer/mni/data
ENV FMRI_ANALYSIS_DIR=/opt/freesurfer/fsfast
ENV PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
ENV MNI_PERL5LIB=/opt/freesurfer/mni/lib/perl5/5.8.5
ENV PATH=/opt/freesurfer/bin:/opt/freesurfer/fsfast/bin:/opt/freesurfer/tktools:/opt/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
RUN echo "cHJpbnRmICJrcnp5c3p0b2YuZ29yZ29sZXdza2lAZ21haWwuY29tXG41MTcyXG4gKkN2dW12RVYzelRmZ1xuRlM1Si8yYzFhZ2c0RVxuIiA+IC9vcHQvZnJlZXN1cmZlci9saWNlbnNlLnR4dAo=" | base64 -d | sh


RUN apt-get install -y tree htop
RUN apt-get install -y tcsh
RUN apt-get install -y bc
RUN apt-get install -y tar libgomp1 perl-modules

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g bids-validator@0.19.8

RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python2.7
RUN apt-get install -y python-pip

RUN pip3 install pandas
RUN pip3 install pybids
#RUN curl -sSLO https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh && \
#    bash Miniconda3-4.3.11-Linux-x86_64.sh -b -p /usr/local/miniconda && \
#    rm Miniconda3-4.3.11-Linux-x86_64.sh
#
#ENV PATH=/usr/local/miniconda/bin:$PATH \
#    LANG=C.UTF-8 \
#    LC_ALL=C.UTF-8
#
#RUN 2to3-3.4 -w $FREESURFER_HOME/bin/aparcstats2table
#RUN 2to3-3.4 -w $FREESURFER_HOME/bin/asegstats2table
#RUN 2to3-3.4 -w $FREESURFER_HOME/bin/tractstats2table
#RUN 2to3-3.4 -w $FREESURFER_HOME/bin/*.py



RUN mkdir /scratch
RUN mkdir /local-scratch

RUN mkdir -p /code
COPY run.py /code/run.py
COPY tracula.py /code/tracula.py
RUN chmod +x /code/run.py

COPY version /version

ENTRYPOINT ["/code/run.py"]
