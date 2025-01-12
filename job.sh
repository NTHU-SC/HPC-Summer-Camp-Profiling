#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --partition=development
#SBATCH --account=ACD114003

module load intel
source /pkg/compiler/intel/2024/vtune/2024.0/vtune-vars.sh 
export LC_CTYPE=en_US

make

export OMP_NUM_THREADS=112

time ./mat_mul_a
time ./mat_mul_b
time ./mat_mul_c
