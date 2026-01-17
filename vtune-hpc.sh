#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --partition=ct112
#SBATCH --account=GOV115003
#SBATCH --cpus-per-task=112

module load intel/2022_3_1
source /pkg/compiler/intel/2024/vtune/2024.0/vtune-vars.sh 
export LC_CTYPE=en_US

make clean
make

export OMP_NUM_THREADS=112

rm -rf vtune-hpc-a
rm -rf vtune-hpc-b
rm -rf vtune-hpc-c

# TODO 2 : Try to modify the hotspot command to the vtune command that collect "hpc-performance" and save the result to vtune-hpc-a / -b / -c
# hotspots : vtune -collect hotspots -r vtune-hs-a ./mat_mul_a
