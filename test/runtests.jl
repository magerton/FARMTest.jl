using FARMTest
using Test
using Distributed, SlurmClusterManager

@testset "FARMTest.jl" begin

    # SLURM only startup
    if "SLURM_JOBID" in keys(ENV)
        println_time_flush("slurm addprocs")
        pids1 = addprocs(SlurmManager(; verbose=true))
        @everywhere println("hello from $(myid()):$(gethostname())")
        println_time_flush("removing procs $pids1")
        rmprocs(pids1)
    end

    # using FARMTest
    println_time_flush("startup workers")
    pids2 = FARMTest.start_up_workers(ENV)
    @everywhere println("hello again from $(myid()):$(gethostname())")
    println_time_flush("removing procs $pids2")
    rmprocs(pids2)


    println_time_flush("done")

end
