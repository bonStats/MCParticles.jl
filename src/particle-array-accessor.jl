function weights(p::Array{<:Particle{T}}; logscale = true, normalscale = true) where {T<:Any}
    logw = vec(getfield.(p, :ℓw))
    if normalscale
        logw = normalise(logw)
    end
    if logscale
        return logw
    else
        return exp.(logw)
    end
end

function location(p::Array{Particle{T}}; flatten = false) where {T<:Any}
    if(flatten)
        loc = vec.(getfield.(p, :x))
    else
        loc = getfield.(p, :x)
    end
    return loc
end

function logdensity(p::Array{DynamicParticle{T}}) where {T<:Any}
    logdensityval = vec(getfield.(p, :cacheℓdens))
    return logdensityval
end
