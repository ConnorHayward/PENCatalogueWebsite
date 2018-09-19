__precompile__(true)

module PENCatalogueManager

### Check for required modules.

# if !isdir(Pkg.dir("Glob"))
# Pkg.add("Glob")
# end
#
# if !isdir(Pkg.dir("JSON"))
# Pkg.add("JSON")
# end
#
# if !isdir(Pkg.dir("FileIO"))
# Pkg.add("FileIO")
# end

### Creating files for batches and tiles####
using FileIO
using JSON
using Glob

include("addentry.jl")
include("editentry.jl")
include("util.jl")

end #module
