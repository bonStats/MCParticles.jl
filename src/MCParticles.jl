module MCParticles
using Distributions

export Particle, StaticParticle, DynamicParticle
#export weights, location, logdensity
#export reweight
#export mutate

include("helper-functions.jl")
include("particle-constructor.jl")
#include("particle-array-accessor.jl")
#include("particle-reweight.jl")
#include("particle-mutate.jl")


end
