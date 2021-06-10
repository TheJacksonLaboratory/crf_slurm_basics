#!/bin/env bash
#SBATCH -q batch
#SBATCH -p compute
#SBATCH -N 1
#SBATCH -c 1 
#SBATCH -t 1:00:00
#SBATCH --mem 4G
#SBATCH -J ex3
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

## afterany: start after other job finishes
## afterok: start after other job finishes successfully

echo "1a started at $SECONDS seconds" 
jid1=$(sbatch ex1.sh test_input1.txt | grep -o "[0-9]*")
echo "jid1:$jid1"

echo "1b started at $SECONDS seconds"
jid2=$(sbatch -d afterany:$jid1 ex1.sh test_input2.txt | grep -o "[0-9]*")
echo "jid2:$jid2"

echo "1c started at $SECONDS seconds"
jid3=$(sbatch -d afterok:$jid2 ex1.sh test_input3.txt  | grep -o "[0-9]*")
echo "jid3:$jid3"

echo "end at $SECONDS seconds"
exit 0

