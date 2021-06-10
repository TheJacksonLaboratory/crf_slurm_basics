#!/bin/env bash
#SBATCH -q batch                   ## which qos
#SBATCH -p compute                 ## which partition
#SBATCH -N 1                       ## number of nodes
#SBATCH -c 1                       ## number of cpus/node
#SBATCH -t 1:00:00                 ## timelimit d-hh:mm:ss
#SBATCH --mem 4G                   ## RAM/node in GiB 
#SBATCH -J ex1                     ## this job's slurm label/name
#SBATCH -o ./logs/%x.%j.out        ## where stdout goes; %x: slurm name; %j: SLURM_JOB_ID
#SBATCH -e ./logs/%x.%j.err        ## where stderr goes

file="$1"

echo "start at $(date)"
echo "pid: $$"
echo "hostname: $(hostname)"
echo "SLURM_JOB_ID: '$SLURM_JOB_ID'"
echo "SLURM_ARRAY_JOB_ID: '$SLURM_ARRAY_JOB_ID'"
echo "SLURM_ARRAY_TASK_ID: '$SLURM_ARRAY_TASK_ID'"
echo "SLURM_NNODES: '$SLURM_NNODES'"
echo "SLURM_JOB_CPUS_PER_NODE: '$SLURM_JOB_CPUS_PER_NODE'"
echo "SLURM_MEM_PER_NODE: '$SLURM_MEM_PER_NODE'"

## bash nlines:
echo "bash file_in: '$file'"
nlines=$(grep -c '' "$file" 2>&1)
[ $? -eq 0 ] || {
  echo "grep error on '$file': $nlines" >&2
  exit 11
}
echo "bash nlines: $nlines"

## python nlines:
python3 ./test_program.py "$file"

## R nlines:
./test_program.R "$file"

echo taking a nap
sleep 5

echo "end at $(date)"
exit 0

