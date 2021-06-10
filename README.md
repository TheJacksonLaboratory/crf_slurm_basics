# Slurm Basics
## For JAX Sumner Cluster

In this guide we provide some basic bash slurm examples. We also provide some very basic python and R example scripts which are run by the slurm scripts. In order to use the examples, you need to have the slurm commands `srun` and `sbatch` in your `$PATH`, as well as `Rscript` and `python3`. The repository also includes three example input files for processing. The example R and python scripts simply count the number of lines in example input files.

---

After changing to the directory with the scripts and example input files, you can run the example R script on individual example input files interactively from the command line as follows:

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

As you may know, we can execute several commands in sequence using a bash script. The following bash script will first determine the number of lines in the input file using the bash `grep` command, then using the python example script, then finally with the R example script:

```
## count number of lines in files three different ways:
bash ex1.sh test_input1.txt
bash ex1.sh test_input2.txt
bash ex1.sh test_input3.txt
```

The previous example was run interactively on the same node you are currently on, using the same resource allocation you are currently using. Often you want the job to run even after your session with the server has stopped, and you may often want or need a new allocation of resources for your job. For instance, perhaps your job needs many more nodes or threads or RAM than you currently have allocated. In such cases, you can use slurm to allocate resources for a particular job. The resources needed can be specified either using the command line or using special sbatch directives within a bash script that you call. The `ex1.sh` script has such sbatch directives within it. Each such sbatch directive line begins with `#SBATCH` then specifies one of the many command line flags available (`man sbatch` details available flags and their meanings). Because the sbatch directives embedded in the bash script `ex1.sh` all start with the bash comment character `#`, you can still run the script using just bash, which can be useful during script development. Here are examples of invoking the script with the `sbatch` command, which allocates additional resources for every instance of the script that is executed:

```
## queue up the script:
sbatch ex1.sh test_input1.txt           ## this will print out the JOBID

## see where it is in the queue; 
##   JOBID can be used to get more information about the job, or can be used to kill the job with scancel command.
##   ST is the state, which is most commonly PD (pending) or R (running);
##   NODELIST(REASON) is either the node(s) on which the job is running, or reason why it is pending;

squeue -u $(whoami)                     ## -u limit output to this specific user
## scancel -j JOBID_GOES_HERE           ## how to cancel one specific job
## scancel -u $(whoami)                 ## kill all this users jobs
```

