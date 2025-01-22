#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --partition=hpcxai1
#SBATCH --account=ACD114003
#SBATCH --cpus-per-task=112

module load intel/2022_3_1
source /pkg/compiler/intel/2024/vtune/2024.0/vtune-vars.sh 
export LC_CTYPE=en_US

make clean
make

export OMP_NUM_THREADS=112

rm -r vtune-hpc-a
rm -r vtune-hpc-b

vtune -collect hpc-performance -r vtune-hpc-a ./mat_mul_a
vtune -collect hpc-performance -r vtune-hpc-b ./mat_mul_b
