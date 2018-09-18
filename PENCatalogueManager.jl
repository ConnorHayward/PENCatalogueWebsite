__precompile__(true)

module PENCatalogueManager

###Creating files for batches and tiles####
using FileIO
using JSON
using Glob

include("src/addentry.jl")
include("src/editentry.jl")
include("src/util.jl")

end #module
