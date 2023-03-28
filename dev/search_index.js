var documenterSearchIndex = {"docs":
[{"location":"generated/demo/","page":"-","title":"-","text":"EditURL = \"https://github.com/Yuan-Ru-Lin/IceCubePublicDataReader.jl/blob/main/examples/demo.jl\"","category":"page"},{"location":"generated/demo/","page":"-","title":"-","text":"using Statistics, Plots, IceCubePublicDataReader\n\ncolormapping1(t) = RGB(cos(π/2 * t), sin(π/2 * t), 0)\ncolormapping2(t) = RGB(0, cos(π/2 * t), sin(π/2 * t))\ncolormapping3(t) = RGB(sin(π/4 * t), 0, cos(π/4 * t))\n\nfunction colormapping(t)\n    t_prime = 3t\n    if t_prime <= 1\n        return colormapping1(t_prime % 1)\n    elseif t_prime <= 2\n        return colormapping2(t_prime % 1)\n    else\n        return colormapping3(t_prime % 1)\n    end\nend\n\nkw = (; markersize=5, grid=true, xlim=(-1000, 1000), ylim=(-1000, 1000))\n\nfunction myplot(event::Event)\n    ts = [hit.t for hit in event.hits]\n    m = mean(ts)\n    s = std(ts)\n    skim = filter(hit -> abs((hit.t - m) / s) < 0.8, event.hits)\n\n    pxz = plot()\n    pyz = plot()\n    for hit in skim\n        t = (hit.t - m) / s / 0.8 / 2 + 0.5\n        c = colormapping(t)\n        scatter!(pxz, (hit.x, hit.z), markercolor=c, xlabel=\"x (m)\", ylabel=\"z (m)\"; kw...)\n        scatter!(pyz, (hit.y, hit.z), markercolor=c, xlabel=\"y (m)\", ylabel=\"z (m)\"; kw...)\n    end\n    plot(pxz, pyz)\nend\n\nopen(joinpath(pkgdir(IceCubePublicDataReader), \"data\", \"Level1_IC59_data_Run00115150_Part00000000_Event11.odf\")) do f\n    event = read(f, Event)\n    myplot(event)\nend","category":"page"},{"location":"generated/demo/","page":"-","title":"-","text":"","category":"page"},{"location":"generated/demo/","page":"-","title":"-","text":"This page was generated using Literate.jl.","category":"page"},{"location":"#Introduction","page":"Home","title":"Introduction","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The package implements I/O for IceCube Public Data Set whose spec is illustrated in https://icecube.umd.edu/PublicData/.","category":"page"}]
}
