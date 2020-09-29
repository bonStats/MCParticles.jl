using MCParticles
using Test

@testset "MCParticles.jl constructor: DynamicParticle" begin
    # Constructor tests
    f(x,t) = -sum(x) + t
    dyn_p1_1 = DynamicParticle([1.0,1.0], log(1.0), f, 1.0, f([1.0,1.0],1.0))
    dyn_p1_2 = Particle([1.0,1.0], 1.0, f, 1.0)
    @test pequal(dyn_p1_1,dyn_p1_2)

    g(x) = -sum(x)
    dyn_p2_1 = DynamicParticle([1.0 1.0], log(1.0), g, 1, g([1.0 1.0]))
    dyn_p2_2 = Particle([1.0 1.0], 1.0, g, 1)
    @test pequal(dyn_p2_1,dyn_p2_2)
end

@testset "MCParticles.jl constructor: StaticParticle" begin
    # Constructor tests
    stat_p1_1 = StaticParticle([1.0,1.0], log(1.0))
    stat_p1_2 = Particle([1.0,1.0], 1.0)
    @test pequal(stat_p1_1, stat_p1_2)
end

@testset "MCParticles.jl helper functions" begin
    # MCParticles.normalise
    lw = [ -8, -4, -2, 0, 2, 4, 8] .* log(10.0)
    lsumw = log( sum(10.0 .^ [ -8, -4, -2, 0, 2, 4, 8]) )
    nlw = lw .- lsumw
    normalise_nlw = MCParticles.normalise(lw)
    @test normalise_nlw ≈ nlw
end

@testset "MCParticles.jl accessor functions" begin
    #dynamic particles
    f(x,t) = -sum(x) + t
    dyn_p1 = Particle([1.0,1.0], 1.0, f, 1.0)
    dyn_p2 = Particle([1.0,2.0], 0.5, f, 1.0)
    arr_dyn_p = [dyn_p1, dyn_p1, dyn_p2, dyn_p2]
    arr_w = [1.0, 1.0, 0.5, 0.5]
    @test weights(arr_dyn_p, logscale = false, normalscale = false) ≈ arr_w
    @test weights(arr_dyn_p, logscale = true, normalscale = false) ≈ log.(arr_w)
    @test weights(arr_dyn_p, logscale = false, normalscale = true) ≈ arr_w/3.0
    # static particles
    stat_p1 = Particle([1.0,1.0], 1.0)
    stat_p2 = Particle([1.0,1.0], 0.5)
    arr_stat_p = [stat_p1, stat_p1, stat_p2, stat_p2]
    @test weights(arr_stat_p, logscale = false, normalscale = false) ≈ arr_w
    @test weights(arr_stat_p, logscale = true, normalscale = false) ≈ log.(arr_w)
    @test weights(arr_stat_p, logscale = false, normalscale = true) ≈ arr_w/3.0
end

@testset "MCParticles.jl mutate functions" begin
    #DynamicParticle
    f(x,t) = -sum(x) + t
    dyn_p1 = Particle([1.0,1.0], 1.0, f, 1.0)
    dyn_p2 = Particle([1.0,2.0], 1.0, f, 2.0)
    dyn_p1 = mutate(dyn_p1, [1.0,2.0], 2.0)
    @test pequal(dyn_p1, dyn_p2)
    #StaticParticle
    stat_p1 = Particle([1.0,1.0], 1.0)
    stat_p2 = Particle([1.0,2.0], 1.0)
    stat_p1 = mutate(stat_p1, [1.0,2.0])
    @test pequal(stat_p1, stat_p2)
end

@testset "MCParticles.jl reweight functions" begin
    #DynamicParticle
    # f(x,t) = -sum(x) + t
    # dyn_p1 = Particle([1.0,1.0], 1.0, f, 1.0)
    # dyn_p2 = Particle([1.0,2.0], 1.0, f, 2.0)
    # dyn_p1 = mutate(dyn_p1, [1.0,2.0], 2.0)
    # @test pequal(dyn_p1, dyn_p2)
    #StaticParticle
    stat_p1 = Particle([1.0,1.0], 1.0)
    stat_p2 = Particle([1.0,1.0], 2.0)
    stat_p1 = reweight(stat_p1, 2.0)
    @test pequal(stat_p1, stat_p2)
end
