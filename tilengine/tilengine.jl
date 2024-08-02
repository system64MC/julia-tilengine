module Tilengine
using Libdl

global tlnLib = Libdl.dlopen("libTilengine.so")

include("engine.jl")
include("bitmap.jl")
include("layers.jl")
include("window.jl")

using .Setup
using .Bitmaps
using .Layers
using .Windowing

export init

end
