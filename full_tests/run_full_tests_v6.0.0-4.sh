#!/usr/bin/env bash

# cd /data.nfs/ds114/tracula_full_tests
# screen -L bash run_full_tests_....sh ds114_test1 and
# screen -L bash run_full_tests_....sh ds114_test2

ds_name=$1
echo Running ${ds_name}

tracula_version=v6.0.0-4beta
wd=/data.nfs/ds114/tracula_full_tests/${tracula_version}

data_dir=${wd}/data
out_root_dir=${wd}/out

mkdir -p $data_dir
mkdir -p $out_root_dir
chmod -R 777 ${data_dir}
chmod -R 777 ${out_root_dir}

if [[ ! -d ${data_dir}/ds114_test1 ]]; then wget -c -O ${data_dir}/ds114_test1.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e54a326c613b01d7d3ed90" && tar xf ${data_dir}/ds114_test1.tar -C ${data_dir}; fi
if [[ ! -d ${data_dir}/ds114_test2 ]]; then wget -c -O ${data_dir}/ds114_test2.tar "https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e549f9b83f6901d457d162" && tar xf ${data_dir}/ds114_test2.tar -C ${data_dir}; fi
if [[ -e ${data_dir}/*.tar ]]; then rm -r ${data_dir}/*.tar; fi





in_dir=${data_dir}/${ds_name}
out_dir=${out_root_dir}/${ds_name}
mkdir -p $out_dir
chmod -R 777 $out_dir
cd $out_dir

docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out participant \
--license_key xxx \
--n_cpus 32


docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group1 \
--license_key xxx


docker run --rm -ti \
-v ${in_dir}:/data/in \
-v ${out_dir}:/data/out \
bids/tracula:${tracula_version} \
/data/in /data/out group2 \
--license_key xxx

tar -zcvf ${wd}/results_tracula_${tracula_version}_${ds_name}.tar.gz ${out_dir}

