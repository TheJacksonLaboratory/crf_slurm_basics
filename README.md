# Slurm Basics
## For JAX Sumner Cluster

In this guide we provide some basic bash slurm examples. We also provide some very basic python and R example scripts which are run by the slurm scripts.

---

### Setup

To run the examples, simply clone this github repo and change into the `slurm_basics` folder. In order to run the examples, you need to have the slurm commands `srun` and `sbatch` in your `$PATH`, as well as the script interpreters `Rscript` (part of a standard R installation) and `python3` (we used f-strings). The repository also includes three example input files for processing. The example R and python scripts simply count the number of lines in example input files.

---

### Running the python and R scripts

After changing to the `slurm_basics` directory containing the scripts and example input files, you can run the example R script on individual example input files interactively from the command line as follows:

```
## fire off R script on each input in turn:
test_program.R test_input1.txt
test_program.R test_input2.txt
test_program.R test_input3.txt
```

Similary, you can run the example python script on individual example input files as follows:

```
## fire off python script on each input in turn:
python3 test_program.R test_input1.txt
python3 test_program.R test_input2.txt
python3 test_program.R test_input3.txt
```

---

### Running a basic slurm bash script

As you may know, we can execute several commands in sequence using a bash script. The following bash script will first determine the number of lines in the input file using the bash `grep` command, then using the python example script, then finally with the R example script:

```
## count number of lines in files three different ways:
bash ex1.sh test_input1.txt
bash ex1.sh test_input2.txt
bash ex1.sh test_input3.txt
```

The previous example was run interactively on the same node you are currently on, using the same resource allocation you are currently using. Often you want the job to run even after your session with the server has stopped, and you may often want or need a new allocation of resources for your job. For instance, perhaps your job needs many more nodes or threads or RAM than you currently have allocated. In such cases, you can use slurm to allocate resources for a particular job. The resources needed can be specified either using the command line or using special `sbatch` directives within a bash script that you call. The `ex1.sh` script has such `sbatch` directives within it. Each such `sbatch` directive line begins with `#SBATCH` then specifies one of the many command line flags available (`man sbatch` details available flags and their meanings). Because the `sbatch` directives embedded in the bash script `ex1.sh` all start with the bash comment character `#`, you can still run the script using just bash, which can be useful during script development. Here are examples of invoking the script with the `sbatch` command, which allocates additional resources for every instance of the script that is executed:

```
## queue up the script:
sbatch ex1.sh test_input1.txt           ## this will print out the JOBID

## see where it is in the queue; 
##   JOBID can be used to get more information about the job, or can be used to kill the job with scancel command.
##   ST is the state, which is most commonly PD (pending) or R (running);
##   NODELIST(REASON) is either the node(s) on which the job is running, or reason why it is pending;

squeue -u $(whoami)                     ## -u limit output to this specific user
## scancel -j <JOBID>                   ## how to cancel one specific job
## scancel -u $(whoami)                 ## kill all this users jobs
```

After the slurm job finishes, the job will no longer show up using the `squeue` command. However, you can use the JOBID to find out what happened to the job (exit codes, timing, resource usage, etc) using the slurm `sacct -j <JOBID>` command. The `ex1.sh` script specifies the `sbatch` `-o` and `-e` options, which indicate where `stdout` and `stderr` streams should be directed. In this example, `stdout` and `stderr` are directed to separate files in the `logs` subdirectory within `slurm_basics` directory. The files are named using the job name and the jobid, so subsquent invocations will not overwrite older log files. Several useful environment variables set by slurm were printed out the the log files. These include identifiers such as the `JOBID`, as well as resources such as the number of compute nodes allocated `SLURM_NNODES`, the number of CPUs allocated per node `SLURM_JOB_CPUS_PER_NODE` and the amount of memory allocated per node `SLURM_MEM_PER_NODE`. So you can view how the allocations change with different invocations. We can change resource allocations from the defaults specified in the batch file `ex1.sh`, by overriding them from the command line: 

```
sbatch ex1.sh test_input1.txt                ## allocation using defaults specified using SBATCH directivers in ex1.sh
sbatch -c 4 ex1.sh test_input2.txt           ## override the number of cpus per node
sbatch -c 4 --mem 8G ex1.sh test_input3.txt  ## override number of cpus/node as well as RAM/node
```

Normally `sbatch` queues a job, prints out the `JOBID` for the queued job, and returns immediately. The exit status will be that of the `sbatch` command itself. However, if we use the `-W` (wait) flag for `sbatch`, the `sbatch` command will not exit till the job is done, then exit with the same exit code as the job itself:

```
## each command line does not complete until queued job competes; sbatch $? set to same as the job:
sbatch -W ex1.sh test_input1.txt
sbatch -W ex1.sh test_input2.txt
sbatch -W ex1.sh test_input3.txt
```

