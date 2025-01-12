#!/bin/bash
#SBATCH --job-name=mat_mul-vtune-hs
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --partition=development
#SBATCH --account=ACD114003

module load intel
source /pkg/compiler/intel/2024/vtune/2024.0/vtune-vars.sh 
export LC_CTYPE=en_US

make

export OMP_NUM_THREADS=56

vtune -collect hotspots -r vtune-hs-2 ./mat_mul_c
vtune -report summary -result-dir vtune-hs-2 -format html -report-output vtune-hs-2.html
