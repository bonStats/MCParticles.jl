# Declare types and structs

"""
    Particle{T}

An abstract type with subtypes
- StaticParticle{T}
- DynamicParticle{T}

"""
abstract type Particle{T} end

"""
    StaticParticle{T} <: Particle{T}

- ```x``` Location of particle
- ```ℓw``` Log weight of particle (possibly unnormalised)
"""
struct StaticParticle{T} <: Particle{T}
    x::T # location
    ℓw::Real # log weight
end

"""
    DynamicParticle{T} <: Particle{T}
- ```x``` Location of particle
- ```ℓw``` Log weight of particle (possibly unnormalised)
- ```ℓdens``` Log density function
- ```τ``` Temperature (or index) for ℓdens
- ```cacheℓdens``` Cache of log density at current temperature (or index)
"""
struct DynamicParticle{T} <: Particle{T}
    x::T # location
    ℓw::Real # log weight
    ℓdens::Function # log density (functions by reference)
    τ::Real # temperature (or index) for ℓdens
    cacheℓdens::Real # cache of log density at current temperature (or index)
end

# Constructors - 'DynamicParticle'

"""
    Particle(x::T, w::Real, ℓdens::Function, τ::Real, logweight::Bool = false) where {T<:Any}

Explicit constructor for Particle with type ```DynamicParticle```.
Auto calculates cached log density ```cacheℓdens```

- ```x``` Location of particle
- ```w``` Weight of particle (possibly unnormalised)
- ```ℓdens``` Log density function
- ```τ``` Temperature (or index) for ℓdens
-- ```logweight``` Boolean. Is ```w``` on log scale? Default is ```false```

"""
function Particle(x::T, w::Real, ℓdens::Function, τ::Real, logweight::Bool = false) where {T<:Any}
    if hasmethod(ℓdens, (T, Real))
        cacheℓdens = ℓdens(x, τ)
    elseif hasmethod(ℓdens, Tuple{T})
        cacheℓdens = ℓdens(x)
    else
        cacheℓdens = nothing
    end
    if logweight
        DynamicParticle(x, w, ℓdens, τ, real(cacheℓdens))
    else
        DynamicParticle(x, log(w), ℓdens, τ, real(cacheℓdens))
    end

end

"""
    Particle(initial::D, ℓdens::Function, w::Real = 0.0, τ::Real = 0.0, logweight::Bool = false) where {D<:Distribution}

Constructor Particle with type ```DynamicParticle``` from initial distribution ```init_distribution```.
Draws sample from ```init_distribution``` and
Auto calculates cached log density ```cacheℓdens```

- ```initial``` Initial distribution
- ```ℓdens``` Log density function
- ```w``` Weight of particle (possibly unnormalised)
- ```τ``` Temperature (or index) for ℓdens
- ```logweight``` Boolean. Is ```w``` on log scale? Default is ```false```

"""
#Particle generated from intial distribution
function Particle(initial::D, ℓdens::Function, w::Real = 1.0, τ::Real = 0.0, logweight::Bool = false) where {D<:Distribution}
    x = rand(initial, 1)
    Particle(x, w, ℓdens, τ, logweight)
end

# Constructors - 'SimpleParticle'
"""
    Particle(x::T, w::Real, logweight::Bool = false) where {T<:Any}

Explicit constructor for Particle with type ```StaticParticle```.

- ```x``` Location of particle
- ```w``` Weight of particle (possibly unnormalised)
- ```logweight``` Boolean. Is ```w``` on log scale? Default is ```false```
"""
function Particle(x::T, w::Real, logweight::Bool = false) where {T<:Any}
    if logweight
        StaticParticle(x, w)
    else
        StaticParticle(x, log(w))
    end
end

"""
    Particle(initial::D, w::Real = 1.0, logweight::Bool = false) where {D<:Distribution}

Constructor Particle with type ```StaticParticle``` from initial distribution ```init_distribution```.
Draws sample from ```init_distribution```

- ```initial``` Initial distribution
- ```w``` Weight of particle (possibly unnormalised)
- ```logweight``` Boolean. Is ```w``` on log scale? Default is ```false```

"""
#Particle generated from intial distribution
function Particle(initial::D, w::Real = 1.0, logweight::Bool = false) where {D<:Distribution}
    x = rand(initial, 1)
    Particle(x, w, logweight)
end
