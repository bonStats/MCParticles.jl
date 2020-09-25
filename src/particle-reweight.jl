function reweight(p::StaticParticle{T}, ℓw::Real) where {T<:Any}

    StaticParticle(p.x, ℓw)

end


function reweight(p::DynamicParticle{T}, τ::Real) where {T<:Any}
    if p.τ == τ
        error("Current particle and  proposal particle have same temperatures τ")
    end

    newlogdensval = p.logdensity(p.x, τ)

    logweight = newlogdensval -
        p.cacheℓdens +
        p.ℓw

    DynamicParticle(p.x, logweight, p.ℓdens, τ, newlogdensval)

end
