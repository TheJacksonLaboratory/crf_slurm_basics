#!/bin/env bash
#SBATCH -q batch
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 1:00:00
#SBATCH --mem 4G
#SBATCH --array=1-3                   ## array indices; can assign range, or e.g. --array=1,3,7,9,21
#SBATCH -J ex4
#SBATCH -o ./logs/%x.%A.%a.out        ## %A: array master job_id; %a: array index number
#SBATCH -e ./logs/%x.%A.%a.err  

SECONDS=0

echo "start at $SECONDS seconds"
echo "pid: $$"
echo "hostname: $(hostname)"
echo "SLURM_JOB_ID: '$SLURM_JOB_ID'"
echo "SLURM_ARRAY_JOB_ID: '$SLURM_ARRAY_JOB_ID'"
echo "SLURM_ARRAY_TASK_ID: '$SLURM_ARRAY_TASK_ID'"
echo "SLURM_JOB_CPUS_PER_NODE: '$SLURM_JOB_CPUS_PER_NODE'"
echo "SLURM_MEM_PER_NODE: '$SLURM_MEM_PER_NODE'"

file_in="test_input${SLURM_ARRAY_TASK_ID}.txt"
echo "file_in: '$file_in'"

sbatch ex1.sh "$file_in"

echo "end at $SECONDS seconds"
exit 0

