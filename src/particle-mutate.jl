"""
    mutate(p::StaticParticle{T}, x::T) where {T<:Any}

Mutate a particle - update the location.

- ```p``` Particle to update
- ```x``` New location of particle

"""
function mutate(p::StaticParticle{T}, x::T) where {T<:Any}

    StaticParticle(x, p.ℓw)

end

"""
    mutate(p::DynamicParticle{T}, x::T, τ::Real = p.τ) where {T<:Any}

    Mutate a particle - update the location.

    - ```p``` Particle to update
    - ```x``` New location of particle
    - ```τ``` New temperature (or index) for ℓdens (defaults to old temperature)

"""
function mutate(p::DynamicParticle{T}, x::T, τ::Real = p.τ) where {T<:Any}
    # recalculates cached density
    # logweight = true
    Particle(x, p.ℓw, p.ℓdens, τ, true)

end
