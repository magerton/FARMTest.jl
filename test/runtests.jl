using FARMTest
using Test
using Distributed, SlurmClusterManager

@testset "FARMTest.jl" begin
    
    if "SLURM_JOBID" in keys(ENV)
        np = parse(Int, ENV["SLURM_NTASKS"])
    else
        np = Sys.CPU_THREADS
    end
    println_time_flush("regular addprocs")
    pids0 = addprocs(np)
    @everywhere println("hello from $(myid()):$(gethostname())")
    rmprocs(pids0)

    if "SLURM_JOBID" in keys(ENV)
        println_time_flush("slurm addprocs")
        pids1 = addprocs(SlurmManager(; verbose=true))
        @everywhere println("hello from $(myid()):$(gethostname())")
        rmprocs(pids1)
    end

    println_time_flush("startup workers")
    pids2 = FARMTest.start_up_workers(ENV)
    @everywhere println("hello again from $(myid()):$(gethostname())")
    rmprocs(pids2)
    println_time_flush("done")

end
