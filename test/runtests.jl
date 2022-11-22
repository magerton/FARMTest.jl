using FARMTest
using Test
using Distributed, SlurmClusterManager

@testset "FARMTest.jl" begin
    
    pids1 = addprocs(SlurmManager(; verbose=true))
    @everywhere println("hello from $(myid()):$(gethostname())")
    rmprocs(pids1)

    pids2 = FARMTest.start_up_workers(ENV)
    @everywhere println("hello again from $(myid()):$(gethostname())")
    rmprocs(pids2)

end
