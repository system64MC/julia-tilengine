module Tilengine



include("engine.jl")
include("bitmap.jl")
include("layers.jl")
include("window.jl")
include("lib.jl")

using .Setup
using .Bitmaps
using .Layers
using .Windowing

export init

end # module Tilengine
