function mutate(p::StaticParticle{T}, x::T) where {T<:Any}

    StaticParticle(x, p.ℓw)

end

function mutate(p::DynamicParticle{T}, x::T; τ::Real = p.τ) where {T<:Any}
    # recalculates cached density
    Particle(x, p.ℓw, p.ℓdens, τ)

end
