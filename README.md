# FARMTest

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://magerton.github.io/FARMTest.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://magerton.github.io/FARMTest.jl/dev/)
[![Build Status](https://travis-ci.com/magerton/FARMTest.jl.svg?branch=main)](https://travis-ci.com/magerton/FARMTest.jl)
[![Coverage](https://codecov.io/gh/magerton/FARMTest.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/magerton/FARMTest.jl)

This package shows how to use Julia with SLURM SBATTCH scripts. 

- `test/runtests.jl` starts Julia on all workers twice (once if not on SLURM), has them load this package, and print their IDs
- `test/runtests.sh` is the SBATCH script to submit the job to SLURM
  
The primary function is `start_up_workers`, which will use [SlurmClusterManager.jl](https://github.com/kleinhenz/SlurmClusterManager.jl) to start up workers when on SLURM, or regular `Distributed::addprocs` if not.
