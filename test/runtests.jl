using MCParticles
using Test

@testset "MCParticles.jl constructor: DynamicParticle" begin
    # Constructor tests
    f(x,t) = -sum(x) + t
    dyn_p1_1 = DynamicParticle([1.0,1.0], 1.0, f, 1.0, f([1.0,1.0],1.0))
    dyn_p1_2 = Particle([1.0,1.0], 1.0, f, 1.0)
    @test all([
        dyn_p1_1.x == dyn_p1_2.x,
        dyn_p1_1.ℓw == dyn_p1_2.ℓw,
        dyn_p1_1.ℓdens == dyn_p1_2.ℓdens,
        dyn_p1_1.cacheℓdens == dyn_p1_2.cacheℓdens,
        dyn_p1_1.τ == dyn_p1_2.τ])
    g(x) = -sum(x)
    dyn_p2_1 = DynamicParticle([1.0 1.0], 1.0, g, 1, g([1.0 1.0]))
    dyn_p2_2 = Particle([1.0 1.0], 1.0, g, 1)
    @test all([
        dyn_p2_1.x == dyn_p2_2.x,
        dyn_p2_1.ℓw == dyn_p2_2.ℓw,
        dyn_p2_1.ℓdens == dyn_p2_2.ℓdens,
        dyn_p2_1.cacheℓdens == dyn_p2_2.cacheℓdens,
        dyn_p2_1.τ == dyn_p2_2.τ])
end

@testset "MCParticles.jl constructor: StaticParticle" begin
    # Constructor tests
    stat_p1_1 = StaticParticle([1.0,1.0], 1.0)
    stat_p1_2 = Particle([1.0,1.0], 1.0)
    @test all([
        stat_p1_1.x == stat_p1_2.x,
        stat_p1_1.ℓw == stat_p1_2.ℓw])
end

@testset "MCParticles.jl helper functions" begin
    # MCParticles.safe_normalise
    ulw = log.(vcat(repeat([1], 1000),[10000]))
    nlw = ulw .- log(11000)
    unsafe_sum_diff = abs(sum(exp.(nlw))- 1)
    safe_sum_diff = abs(sum(exp.(MCParticles.safe_normalise(ulw))) - 1)
    @test unsafe_sum_diff > safe_sum_diff
end

# @testset "MCParticles.jl accessor functions" begin
#     f(x,t) = -sum(x) + t
#     dyn_p1 = Particle([1.0,1.0], 1.0, f, 1.0)
#     dyn_p2 = Particle([1.0,2.0], 0.5, f, 1.0)
#     arr_dyn_p = [dyn_p1, dyn_p1, dyn_p2, dyn_p2]
#     # weights
#     weights(arr_dyn_p)
#     #@test unsafe_sum_diff > safe_sum_diff
# end
