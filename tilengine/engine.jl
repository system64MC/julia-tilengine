module Setup
using Libdl
import ..Tilengine: tlnLib

mutable struct Engine
    _data::Ptr{Cvoid}
end

global _rasterCallback::Union{Function,Nothing} = nothing
global _rUdata = nothing
global _frameCallback::Union{Function,Nothing} = nothing
global _fUdata = nothing
function _CrasterCallback(line::Cint)::Nothing
    if (_rasterCallback !== nothing)
        _rasterCallback(Int32(line), _rUdata)
    end
    return
end

function _CframeCallback(frame::Cint)::Nothing
    if (_frameCallback !== nothing)
        _frameCallback(Int32(frame))
    end
    return
end
const c_rcallback = @cfunction(_CrasterCallback, Cvoid, (Cint,))
const c_fcallback = @cfunction(_CframeCallback, Cvoid, (Cint,))

# Declare the C functions using `ccall`
const tln_init_ptr = Libdl.dlsym(tlnLib, "TLN_Init")
const tln_setRasterCallback_ptr = Libdl.dlsym(tlnLib, "TLN_SetRasterCallback")
const tln_setFrameCallback_ptr = Libdl.dlsym(tlnLib, "TLN_SetFrameCallback")
function init(hres::Integer, vres::Integer, numlayers::Integer, numsprites::Integer, numanimations::Integer)::Engine
    e = Engine(ccall(tln_init_ptr, Ptr{Cvoid}, (Cint, Cint, Cint, Cint, Cint), hres, vres, numlayers, numsprites, numanimations))
    ccall(tln_setRasterCallback_ptr, Cvoid, (Ptr{Cvoid},), c_rcallback)
    ccall(tln_setFrameCallback_ptr, Cvoid, (Ptr{Cvoid},), c_fcallback)
    return e
end

const tln_deinit_ptr = Libdl.dlsym(tlnLib, "TLN_Deinit")
function deinit()::Nothing
    ccall(tln_setRasterCallback_ptr, Cvoid, ())
    return
end

const tln_deleteContext_ptr = Libdl.dlsym(tlnLib, "TLN_DeleteContext")
function deleteContext(engine::Engine)::Bool
    r = ccall(tln_setRasterCallback_ptr, Bool, (Ptr{Cvoid},), engine._data)
    engine._data = C_NULL
    return r
end

const tln_setContext_ptr = Libdl.dlsym(tlnLib, "TLN_SetContext")
function setContext(engine::Engine)::Bool
    return ccall(tln_setContext_ptr, Bool, (Ptr{Cvoid},), engine._data)
end

const tln_getContext_ptr = Libdl.dlsym(tlnLib, "TLN_GetContext")
function getContext()::Engine
    return Engine(ccall(tln_init_ptr, Ptr{Cvoid}, ()))
end

function setRasterCallback(cb::Union{Function,Nothing}, data::Any)::Nothing
    global _rasterCallback = cb
    global _rUdata = data
    return
end

function setRasterData(data::Any)::Nothing
    global _rUdata = data
    return
end

end
