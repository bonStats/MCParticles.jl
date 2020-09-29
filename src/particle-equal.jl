function pequal(p1::DynamicParticle{T}, p2::DynamicParticle{T}) where {T<:Any}
    return all([
        p1.x == p2.x,
        p1.ℓw == p2.ℓw,
        p1.ℓdens === p2.ℓdens,
        p1.cacheℓdens == p2.cacheℓdens,
        p1.τ == p2.τ])
end

function pequal(p1::StaticParticle{T}, p2::StaticParticle{T}) where {T<:Any}
    return all([
        p1.x == p2.x,
        p1.ℓw == p2.ℓw])
end
