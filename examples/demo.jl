# # Demonstration
#
# ## I/O
#
# This package provides basic I/O and print utility for Event.

using IceCubePublicDataReader

demo_file_path = joinpath(pkgdir(IceCubePublicDataReader),
    "data",
    "Level1_IC59_data_Run00115150_Part00000000_Event11.odf")

event = open(demo_file_path) do io
    read(io, Event)
end

# You can also `write` an Event out.

buffer = IOBuffer()
write(buffer, event)
seekstart(buffer)
retrieved_event = read(buffer, Event)

# ## Plotting
#
# Here I replicated the event view shown [here](https://icecube.umd.edu/PublicData/tutorials/TheEventViewer.html).
#
# First I implemented the color mapping defined by the author.

colormapping1(t) = RGB(cos(π/2 * t), sin(π/2 * t), 0)
colormapping2(t) = RGB(0, cos(π/2 * t), sin(π/2 * t))
colormapping3(t) = RGB(sin(π/4 * t), 0, cos(π/4 * t))

function colormapping(t)
    t_prime = 3t
    if t_prime <= 1
        return colormapping1(t_prime % 1)
    elseif t_prime <= 2
        return colormapping2(t_prime % 1)
    else
        return colormapping3(t_prime % 1)
    end
end

# Then I plotted the hits whose colors are determined by the time they are recorded. I skimmed off hits whose time is $0.8\sigma$ away from the mean since otherwise all the hits would have almost the same color.

kw = (; markersize=5,
      grid=true,
      xlim=(-1000, 1000), ylim=(-1000, 1000),
      label=nothing)

using Statistics, Plots

function myplot(event::Event)
    ts = [hit.t for hit in event.hits]
    m = mean(ts)
    s = std(ts)
    skim = filter(hit -> abs((hit.t - m) / s) < 0.8, event.hits)

    pxz = plot()
    pyz = plot()
    for hit in skim
        t = (hit.t - m) / s / 0.8 / 2 + 0.5
        c = colormapping(t)
        scatter!(pxz, (hit.x, hit.z); kw...,
                 markercolor=c, xlabel="x (m)", ylabel="z (m)")
        scatter!(pyz, (hit.y, hit.z); kw...,
                 markercolor=c, xlabel="y (m)", ylabel="z (m)")
    end
    plot(pxz, pyz)
end

myplot(event)

