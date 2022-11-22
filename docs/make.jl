using FARMTest
using Documenter

DocMeta.setdocmeta!(FARMTest, :DocTestSetup, :(using FARMTest); recursive=true)

makedocs(;
    modules=[FARMTest],
    authors="Mark <mjagerton@ucdavis.edu> and contributors",
    repo="https://github.com/magerton/FARMTest.jl/blob/{commit}{path}#{line}",
    sitename="FARMTest.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://magerton.github.io/FARMTest.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/magerton/FARMTest.jl",
    devbranch="main",
)
