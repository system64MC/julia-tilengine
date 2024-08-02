module Layers
using Libdl
import ..Tilengine: tlnLib

const tln_setLayerPosition_ptr = Libdl.dlsym(tlnLib, "TLN_SetLayerPosition")
function setLayerPosition(layer::Integer, x::Number, y::Number)::Bool
    return ccall(tln_setLayerPosition_ptr, Bool, (Cint, Cint, Cint), Cint(layer), Cint(floor(x)), Cint(floor(y)))
end

end
