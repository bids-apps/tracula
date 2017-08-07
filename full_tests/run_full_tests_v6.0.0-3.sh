#!/usr/bin/env bash

# run in /data.nfs/ds114/tracula_full_tests

tracula_version=v6.0.0-3
wd=$PWD/${tracula_version}
data_dir=${wd}/data/
out_root_dir=${wd}/out/

mkdir -p $data_dir
mkdir -p $out_root_dir

if [[ ! -d ${data_dir}/ds114_test1 ]]; then wget -c -O ${data_dir}/ds114_test1.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e54a326c613b01d7d3ed90" && tar xf ${data_dir}/ds114_test1.tar -C ${data_dir}; fi
if [[ ! -d ${data_dir}/ds114_test2 ]]; then wget -c -O ${data_dir}/ds114_test2.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e549f9b83f6901d457d162" && tar xf ${data_dir}/ds114_test2.tar -C ${data_dir}; fi
if [[ ! -d ${data_dir}/ds114_test1_freesurfer ]]; then wget -c -O ${data_dir}/ds114_test1_freesurfer.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/5882adf3b83f6901f564da49" && tar xf ${data_dir}/ds114_test1_freesurfer.tar -C ${data_dir}; fi
if [[ ! -d ${data_dir}/ds114_test2_freesurfer ]]; then wget -c -O ${data_dir}/ds114_test2_freesurfer.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/5882b0e3b83f6901fb64da18" && tar xf ${data_dir}/ds114_test2_freesurfer.tar -C ${data_dir}; fi
if [[ -e ${data_dir}/*.tar ]]; then rm -r ${data_dir}/*.tar; fi




#### ds114_test1
in_dir=${data_dir}/ds114_test1
fs_dir=${data_dir}/ds114_test1_freesurfer
out_dir=${out_root_dir}/ds114_test1
mkdir -p $out_dir
cd $out_dir

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out participant \
--freesurfer_dir /data/fs \
--license_key xxx


screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group1 \
--freesurfer_dir /data/fs \
--license_key xxx


screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group2 \
--freesurfer_dir /data/fs \
--license_key xxx

tar -zcvf ${wd}/results_tracula_${tracula_version}_ds114_test1.tar.gz ${out_dir}



#### ds114_test2
in_dir=${data_dir}/ds114_test2
fs_dir=${data_dir}/ds114_test2_freesurfer
out_dir=${out_root_dir}/ds114_test2
mkdir -p $out_dir
cd $out_dir

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out participant \
--freesurfer_dir /data/fs \
--license_key xxx

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group1 \
--freesurfer_dir /data/fs \
--license_key xxx

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${fs_dir}:/data/fs \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group2 \
--freesurfer_dir /data/fs \
--license_key xxx

tar -zcvf ${wd}/results_tracula_${tracula_version}_ds114_test2.tar.gz ${out_dir}