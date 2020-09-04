module MCParticles
using Distributions

include("particle-constructor.jl")
#include("particle-array-accessor.jl")

export
    Particle
    StaticParticle
    DynamicParticle
    
end
