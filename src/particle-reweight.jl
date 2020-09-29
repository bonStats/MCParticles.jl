"""
    reweight(p::StaticParticle{T}, w::Real, logweight = false) where {T<:Any}

Reweight a particle - update the weight.

- ```p``` Particle to update
- ```w``` New weight of particle
- ```logweight``` Is ```w``` on log scale? Default is ```false```

"""
function reweight(p::StaticParticle{T}, w::Real, logweight = false) where {T<:Any}

    Particle(p.x, w, logweight)

end


# function reweight(p::DynamicParticle{T}, τ::Real) where {T<:Any}
#     if p.τ == τ
#         error("Current particle and  proposal particle have same temperatures τ")
#     end
#
#     newlogdensval = p.logdensity(p.x, τ)
#
#     logweight = newlogdensval -
#         p.cacheℓdens +
#         p.ℓw
#
#     DynamicParticle(p.x, logweight, p.ℓdens, τ, newlogdensval)
#
# end
