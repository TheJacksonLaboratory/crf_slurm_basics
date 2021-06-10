#!/bin/env bash
#SBATCH -q batch
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -c 1 
#SBATCH -t 1:00:00
#SBATCH --mem 4G
#SBATCH -J ex2
#SBATCH -o ./logs/%x.%j.out
#SBATCH -e ./logs/%x.%j.err

SECONDS=0

echo "start at $SECONDS seconds"
echo "pid: $$"
echo "hostname: $(hostname)"
echo "SLURM_JOB_ID: '$SLURM_JOB_ID'"
echo "SLURM_ARRAY_JOB_ID: '$SLURM_ARRAY_JOB_ID'"
echo "SLURM_ARRAY_TASK_ID: '$SLURM_ARRAY_TASK_ID'"
echo "SLURM_JOB_CPUS_PER_NODE: '$SLURM_JOB_CPUS_PER_NODE'"
echo "SLURM_MEM_PER_NODE: '$SLURM_MEM_PER_NODE'"

## launched in parallel; can customize params w/i cmd line:

echo "parallel 1 started at $SECONDS seconds"
sbatch ex1.sh test_input1.txt

echo "parallel 2 started at $SECONDS seconds"
sbatch -c 2 --mem 16G ex1.sh test_input2.txt

echo "parallel 3 started at $SECONDS seconds"
sbatch -c 4 --mem 8G ex1.sh test_input3.txt

## a more generic way:

for f in test_input*.txt; do
  echo "parallel on '$f' started at $SECONDS seconds"
  sbatch ex1.sh "$f"
done

## launched in series;
##   -W: sbatch waits for job to complete/fail before exiting with job's $?

for f in test_input*.txt; do
  echo "series on '$f' started at $SECONDS seconds"
  sbatch -W ex1.sh "$f"
done

echo "end at $SECONDS seconds"
exit 0

