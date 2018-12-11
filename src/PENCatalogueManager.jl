__precompile__(true)

module PENCatalogueManager

### Check for required modules.

<<<<<<< HEAD
=======
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

>>>>>>> 2f059ee07f42d59ee9590d4bc199aca2affdea86
### Creating files for batches and tiles####
using FileIO
using JSON
using Glob

include("addentry.jl")
include("editentry.jl")
include("util.jl")

end #module
