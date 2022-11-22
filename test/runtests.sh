#!/bin/bash -l
# NOTE the -l flag!
#    see https://stackoverflow.com/questions/20499596/bash-shebang-option-l

#-----------------------
# Job info
#-----------------------

#SBATCH --job-name=Testing_FARMTest_package
#SBATCH --mail-user=mjagerton@ucdavis.edu
#SBATCH --mail-type=ALL

##SBATCH --output out-%j.output
##SBATCH --error out-%j.output

#-----------------------
# Resource allocation
#-----------------------

#SBATCH --time=0-01:00:00     # in d-hh:mm:ss
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=128
#SBATCH --partition=high2
#SBATCH --mem=750000

# https://researchcomputing.princeton.edu/support/knowledge-base/julia

#-----------------------
# script
#-----------------------

cd ~/testjobs

echo ""
hostname
module load julia

# create directory for the month
echo ""
MON=$(date +"%Y-%m")
[ -d $MON ] &&  echo "Directory ${MON} exists" || mkdir $MON

# switch into directory
mkdir ${MON}/${SLURM_JOB_ID}
cd    ${MON}/${SLURM_JOB_ID}
echo ""
echo "Starting job!!! ${SLURM_JOB_ID} on partition ${SLURM_JOB_PARTITION}"
echo ""
# print out versions of repos
echo "FARMTest commit " $(git -C ~/dev-pkgs/FARMTest/ rev-parse HEAD)
# echo "haynesville             commit " $(git -C ~/haynesville/ rev-parse HEAD)
echo ""
# print out environment variables
julia -e '[println((k,ENV[k],)) for k in keys(ENV) if occursin("SLURM_NTASKS",k)];'

# run the script
julia --project=~/dev-pkgs/FARMTest --optimize=3 ~/dev-pkgs/FARMTest/test/runtests.jl
