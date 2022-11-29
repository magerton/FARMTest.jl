module FARMTest

using Distributed, SlurmClusterManager, Dates

export println_time_flush

VERBOSE = false

"workers() but excluding master"
getworkers() = filter(i -> i != 1, workers())

function start_up_workers(ENV::Base.EnvDict; nprocs = Sys.CPU_THREADS)
    # send primitives to workers
    oldworkers = getworkers()
    println_time_flush("removing workers $oldworkers")
    rmprocs(oldworkers)
    flush(stdout)
    
    if "SLURM_JOBID" in keys(ENV)
        num_cpus_to_request = parse(Int, ENV["SLURM_NTASKS"])
        println_time_flush("requesting $(num_cpus_to_request) cpus from slurm.")
        pids = addprocs(SlurmManager(; verbose=VERBOSE); exeflags = "--project=$(Base.active_project())", topology=:master_worker)
    else
        cputhrds = Sys.CPU_THREADS
        cputhrds < nprocs && @warn "using nprocs = $cputhrds < $nprocs specified"
        pids = addprocs(min(nprocs, cputhrds); exeflags = "--project=$(Base.active_project())", topology=:master_worker)
    end
    println_time_flush("Workers added: $pids")
    return pids
end

function println_time_flush(str)
    println(Dates.format(now(), "HH:MM:SS   ") * str)
    flush(stdout)
end

hellostring() = "hello from $(myid()):$(gethostname())"


end
