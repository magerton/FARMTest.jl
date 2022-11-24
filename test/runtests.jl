using FARMTest
using Test
using Distributed, SlurmClusterManager

@testset "FARMTest.jl" begin

    PROJPATH = abspath(joinpath(pathof(FARMTest), "..", ".."))

    # SLURM only startup
    if "SLURM_JOBID" in keys(ENV)
        println_time_flush("\n\nslurm addprocs")
        pids1 = addprocs(SlurmManager(; verbose=true))
        @everywhere begin
            using Pkg
            @eval Pkg.activate($PROJPATH)  # required
            using FARMTest
            println(FARMTest.hellostring())
        end      
        println_time_flush("removing procs $pids1\n\n")
        rmprocs(pids1)
    end

    # using FARMTest
    println_time_flush("\n\nstartup workers")
    pids2 = FARMTest.start_up_workers(ENV)
    @everywhere begin
        using Pkg
        @eval Pkg.activate($PROJPATH)  # required
        using FARMTest
        println(FARMTest.hellostring())
    end
    println_time_flush("removing procs $pids2")
    rmprocs(pids2)


    println_time_flush("\n\ndone!\n\n")

end
