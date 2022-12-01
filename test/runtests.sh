#!/bin/bash -l
# NOTE the -l flag!
#    see https://stackoverflow.com/questions/20499596/bash-shebang-option-l

#-----------------------
# Job info
#-----------------------

#SBATCH --job-name=Testing_FARMTest_package
#SBATCH --mail-user=User@example.edu
#SBATCH --mail-type=ALL

#-----------------------
# Resource allocation
#-----------------------

#SBATCH --time=0-01:00:00     # in d-hh:mm:ss
#SBATCH --ntasks=256
#SBATCH --partition=high2
#SBATCH --mem=384000
#SBATCH --nodes=2

#-----------------------
# script
#-----------------------

echo ""
hostname
module load julia

# -------------------------------
# create directory for the year-month 
# to save data/results to
# (note, SLURM output saved to the directory from which the job was submitted)
# commented out for now
# -------------------------------

# echo ""
# MON=$(date +"%Y-%m")
# [ -d $MON ] &&  echo "Directory ${MON} exists" || mkdir $MON
# switch into directory
# mkdir ${MON}/${SLURM_JOB_ID}
# cd    ${MON}/${SLURM_JOB_ID}
# pwd

# -------------------------------
# some info
# -------------------------------

echo ""
echo "Starting job!!! ${SLURM_JOB_ID} on partition ${SLURM_JOB_PARTITION}"
echo ""
# print out versions of repos
echo "FARMTest commit " $(git -C ~/dev-pkgs/FARMTest/ rev-parse HEAD)
echo ""

# print out environment variables
printenv | grep SLURM

# -------------------------------
# julia!!
# -------------------------------

# run the script
# NOTE - may need to change directory here
julia --project=~/dev-pkgs/FARMTest --optimize=3 ~/dev-pkgs/FARMTest/test/runtests.jl
