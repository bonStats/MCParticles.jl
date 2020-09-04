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
