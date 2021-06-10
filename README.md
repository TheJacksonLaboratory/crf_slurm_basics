#Slurm Basics
##for JAX Sumner Cluster

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

As you may know, we can execute several command lines in sequence using a bash script. The following bash script will first determine the number of lines in the input file using the bash `grep` command, then using the python example script, then finally with the R example script:

```
## count number of lines in files three different ways:
bash ex1.sh test_input1.txt
bash ex1.sh test_input2.txt
bash ex1.sh test_input3.txt
```

