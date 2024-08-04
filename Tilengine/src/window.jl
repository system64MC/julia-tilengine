module Windowing
using Libdl
import ..Tilengine: tlnLib

const WindowFlags = Int32
const CWF_FULLSCREEN::WindowFlags = (1 << 0)
const CWF_VSYNC::WindowFlags = (1 << 1)
const CWF_S1::WindowFlags = (1 << 2)
const CWF_S2::WindowFlags = (2 << 2)
const CWF_S3::WindowFlags = (3 << 2)
const CWF_S4::WindowFlags = (4 << 2)
const CWF_S5::WindowFlags = (5 << 2)
const CWF_NEAREST::WindowFlags = (1 << 6)
const CWF_NOVSYNC::WindowFlags = (1 << 7)

tln_createWindow_ptr = Libdl.dlsym(tlnLib, "TLN_CreateWindow")
function createWindow(overlay::AbstractString, flags::WindowFlags)::Bool
    return ccall(tln_createWindow_ptr, Bool, (Cstring, Cint), overlay, flags)
end

tln_processWindow_ptr = Libdl.dlsym(tlnLib, "TLN_ProcessWindow")
function processWindow()::Bool
    return ccall(tln_processWindow_ptr, Bool, ())
end

tln_drawFrame_ptr = Libdl.dlsym(tlnLib, "TLN_DrawFrame")
function drawFrame(frame::Integer)::Nothing
    ccall(tln_drawFrame_ptr, Nothing, (Cint,), Cint(frame))
    return
end

tln_setWindowTitle_ptr = Libdl.dlsym(tlnLib, "TLN_SetWindowTitle")
function setWindowTitle(title::AbstractString)::Nothing
    ccall(tln_setWindowTitle_ptr, Nothing, (Cstring,), title)
    return
end

end
