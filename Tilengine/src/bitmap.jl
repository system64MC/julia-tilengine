module Bitmaps
using Libdl
import Tilengine: tlnLib

mutable struct Bitmap
    _data::Ptr{Cvoid}
end

tln_loadBitmap_ptr = Libdl.dlsym(tlnLib, "TLN_LoadBitmap")
function loadBitmap(filename::AbstractString)::Bitmap
    return Bitmap(ccall(tln_loadBitmap_ptr, Ptr{Cvoid}, (Cstring,), filename))
end

tln_setLayerBitmap_ptr = Libdl.dlsym(tlnLib, "TLN_SetLayerBitmap")
function setBitmap(layer::Integer, bitmap::Bitmap)::Bool
    return ccall(tln_setLayerBitmap_ptr, Bool, (Cint, Ptr{Cvoid}), Cint(layer), Ptr{Cvoid}(bitmap._data))
end

end
