using Statistics, Plots, IceCubePublicDataReader

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

kw = (; markersize=5, grid=true, xlim=(-1000, 1000), ylim=(-1000, 1000))

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
        scatter!(pxz, (hit.x, hit.z), markercolor=c, xlabel="x (m)", ylabel="z (m)"; kw...)
        scatter!(pyz, (hit.y, hit.z), markercolor=c, xlabel="y (m)", ylabel="z (m)"; kw...)
    end
    plot(pxz, pyz)
end

open(joinpath(pkgdir(IceCubePublicDataReader), "data", "Level1_IC59_data_Run00115150_Part00000000_Event11.odf")) do f
    event = read(f, Event)
    myplot(event)
end

