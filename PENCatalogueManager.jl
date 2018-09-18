module PENCatalogueManager
__precompile__(true)
###Creating files for batches and tiles####
using FileIO
using JSON
using Glob

include("addentry.jl")
include("editentry.jl")
include("util.jl")

end #module
