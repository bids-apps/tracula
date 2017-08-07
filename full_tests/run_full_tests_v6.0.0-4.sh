#!/usr/bin/env bash

# run in /data.nfs/ds114/tracula_full_tests

tracula_version=v6.0.0-4
wd=$PWD/${tracula_version}
data_dir=${wd}/data/
out_root_dir=${wd}/out/

mkdir -p $data_dir
mkdir -p $out_root_dir

if [[ ! -d ${data_dir}/ds114_test1 ]]; then wget -c -O ${data_dir}/ds114_test1.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e54a326c613b01d7d3ed90" && tar xf ${data_dir}/ds114_test1.tar -C ${data_dir}; fi
if [[ ! -d ${data_dir}/ds114_test2 ]]; then wget -c -O ${data_dir}/ds114_test2.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e549f9b83f6901d457d162" && tar xf ${data_dir}/ds114_test2.tar -C ${data_dir}; fi
if [[ -e ${data_dir}/*.tar ]]; then rm -r ${data_dir}/*.tar; fi




#### ds114_test1
in_dir=${data_dir}/ds114_test1
out_dir=${out_root_dir}/ds114_test1
mkdir -p $out_dir
cd $out_dir

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out participant \
--license_key xxx \
--n_cpus 32


screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group1 \
--license_key xxx


screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group2 \
--license_key xxx

tar -zcvf ${wd}/results_tracula_${tracula_version}_ds114_test1.tar.gz ${out_dir}



#### ds114_test2
in_dir=${data_dir}/ds114_test2
out_dir=${out_root_dir}/ds114_test2
mkdir -p $out_dir
cd $out_dir

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out participant \
--license_key xxx \
--n_cpus 32

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group1 \
--license_key xxx

screen -L docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group2 \
--license_key xxx

tar -zcvf ${wd}/results_tracula_${tracula_version}_ds114_test2.tar.gz ${out_dir}