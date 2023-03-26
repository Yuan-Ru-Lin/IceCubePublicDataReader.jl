using Documenter, Literate

EXAMPLE = joinpath(@__DIR__, "..", "examples", "demo.jl")
OUTPUT = joinpath(@__DIR__, "src", "generated")
Literate.markdown(EXAMPLE, OUTPUT)

makedocs(;
    sitename = "IceCubePublicDataReader.jl",
    pages = Any[
        "Home" => "index.md",
        "Demo" => Any["generated/demo.md"],
    ]
)
deploydocs(;
    repo = "github.com/Yuan-Ru-Lin/IceCubePublicDataReader.jl.git",
    push_preview = true,
)
