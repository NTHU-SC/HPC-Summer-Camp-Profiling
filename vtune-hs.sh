#!/bin/bash
#SBATCH --job-name=mat_mul
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --partition=hpcxai1
#SBATCH --account=ACD114003
#SBATCH --cpus-per-task=112

module load intel
source /pkg/compiler/intel/2024/vtune/2024.0/vtune-vars.sh 
export LC_CTYPE=en_US

make clean
make


export OMP_NUM_THREADS=112
rm -r vtune-hs-a

vtune -collect hotspots -r vtune-hs-a ./mat_mul_a
