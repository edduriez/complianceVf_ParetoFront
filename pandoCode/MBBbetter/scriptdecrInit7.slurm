#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=24
#SBATCH --time=24:00:00
#SBATCH --begin=now
#SBATCH --mail-user=edouard.duriez@isae-supaero.fr
#SBATCH --mail-type=FAIL,END
#SBATCH --job-name=decrinit7MBB
#SBATCH -o slurm.%j.out # STDOUT
#SBATCH -e slurm.%j.err # STDERR
#SBATCH --partition=short

module load matlab/2018a

matlab -r "run('mainPandoDecrInit7.m');exit;"