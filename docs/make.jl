using MCParticles
using Documenter

makedocs(;
    modules=[MCParticles],
    authors="Joshua Bon <joshuajbon@gmail.com>",
    repo="https://github.com/bonStats/MCParticles.jl/blob/{commit}{path}#L{line}",
    sitename="MCParticles.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://bonStats.github.io/MCParticles.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bonStats/MCParticles.jl",
)
