# using Distributed

# println("Hello from Julia")
# np = nprocs()
# println("Number of processes: $np")

# for i in workers()
#     host, pid = fetch(@spawnat i (gethostname(), getpid()))
#     println("Hello from process $(pid) on host $(host)!")
# end

# hosts = @distributed for i=1:np
#     println(run(`hostname`))
# end
using Distributed

# launch worker processes
addprocs()

println("Number of processes: ", nprocs())
println("Number of workers: ", nworkers())

# each worker gets its id, process id and hostname
for i in workers()
    id, pid, host = fetch(@spawnat i (myid(), getpid(), gethostname()))
    println(id, " " , pid, " ", host)
end

# remove the workers
for i in workers()
    rmprocs(i)
end