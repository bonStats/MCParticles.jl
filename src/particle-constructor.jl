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
    Particle(x::T, ℓw::Real, ℓdens::Function, τ::Real) where {T<:Any}

Explicit constructor for Particle with type 'DynamicParticle'.
Auto calculates cached log density ```cacheℓdens```

- ```x``` Location of particle
- ```ℓw``` Log weight of particle (possibly unnormalised)
- ```ℓdens``` Log density function
- ```τ``` Temperature (or index) for ℓdens
"""
function Particle(x::T, ℓw::Real, ℓdens::Function, τ::Real) where {T<:Any}
    if hasmethod(ℓdens, (T, Real))
        cacheℓdens = ℓdens(x, τ)
    elseif hasmethod(ℓdens, Tuple{T})
        cacheℓdens = ℓdens(x)
    else
        cacheℓdens = nothing
    end
    DynamicParticle(x, ℓw, ℓdens, τ, real(cacheℓdens))
end

"""
    Particle(initial::D, ℓdens::Function, ℓw::Real = 0.0, τ::Real = 0.0) where {D<:Distribution}

Constructor Particle with type 'DynamicParticle' from initial distribution ```init_distribution```.
Draws sample from ```init_distribution``` and
Auto calculates cached log density ```cacheℓdens```

- ```initial``` Initial distribution
- ```ℓdens``` Log density function
- ```ℓw``` Log weight of particle (possibly unnormalised)
- ```τ``` Temperature (or index) for ℓdens
"""
#Particle generated from intial distribution
function Particle(initial::D, ℓdens::Function, ℓw::Real = 0.0, τ::Real = 0.0) where {D<:Distribution}
    x = rand(initial, 1)
    Particle(x, ℓw, ℓdens, τ)
end

# Constructors - 'SimpleParticle'
"""
    Particle(x::T, ℓw::Real) where {T<:Any}

Explicit constructor for Particle with type 'StaticParticle'.

- ```x``` Location of particle
- ```ℓw``` Log weight of particle (possibly unnormalised)
"""
function Particle(x::T, ℓw::Real) where {T<:Any}
    StaticParticle(x, ℓw)
end
