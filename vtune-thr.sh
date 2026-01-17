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

# TODO 3 : Modify this to find out the best OMP_NUM_THREADS for this program
export OMP_NUM_THREADS=112
rm -rf vtune-thr

vtune -collect threading -r vtune-thr ./mat_mul_c
