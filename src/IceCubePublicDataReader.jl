module IceCubePublicDataReader

export Event, read

import Base: read

readtype(io, ::Type{T}) where T<:Union{Integer, AbstractFloat} =
    ntoh(read(io, T))

struct Hit
    q::Float64
    t::Float64
    x::Float64
    y::Float64
    z::Float64
end

function read(io::IO, ::Type{Hit})
    q = readtype(io, Float64)
    t = readtype(io, Float64)
    x = readtype(io, Float64)
    y = readtype(io, Float64)
    z = readtype(io, Float64)
    Hit(q, t, x, y, z)
end

struct Trigger
    time::Float64
    name::String
end

function read(io::IO, ::Type{Trigger})
    time = readtype(io, Float64)
    nChars = readtype(io, Int32)
    name = String(Char.(read(io, nChars)))
    Trigger(time, name)
end

struct Event
    runID::Int32
    year::Int32
    startTime::Int64
    eventLength::Float64
    nTriggers::Int64
    triggers::Vector{Trigger}
    nHits::Int64
    hits::Vector{Hit}
end

function read(io::IO, ::Type{Event})
    runID = readtype(io, UInt32)
    year = readtype(io, UInt32)
    startTime = readtype(io, Int64)
    eventLength = readtype(io, Float64)

    nTriggers = readtype(io, Int64)
    triggers = [read(io, Trigger) for _ in 1:nTriggers]

    nHits = readtype(io, Int64)
    hits = [read(io, Hit) for _ in 1:nHits]

    Event(runID,
          year,
          startTime,
          eventLength,
          nTriggers,
          triggers,
          nHits,
          hits)
end

end
