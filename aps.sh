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

# time ./mat_mul_a
# time ./mat_mul_b
# time ./mat_mul_c

aps -r aps_result-a ./mat_mul_a
aps-report aps_result-a -H aps_report-a.html

aps -r aps_result-b ./mat_mul_b
aps-report aps_result-b -H aps_report-b.html

aps -r aps_result-c ./mat_mul_c
aps-report aps_result-c -H aps_report-c.html