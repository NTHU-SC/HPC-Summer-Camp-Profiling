#!/bin/bash
#PBS -P ACD110018
#PBS -N HPC-WinteCamp-Profiling
#PBS -l select=1:ncpus=40:ompthreads=40  
#PBS -l walltime=00:30:00
#PBS -q ctest
#PBS -o aps-out.log
#PBS -e aps-err.log

module load intel/2019_u5
. /pkg/intel/2019_u5/vtune_amplifier/amplxe-vars.sh 
export LC_CTYPE=en_US

cd ${PBS_O_WORKDIR:-"."}
make

aps -r aps_result_b ./mat_mul_b
aps-report aps_result_b -O aps_report_b.html
