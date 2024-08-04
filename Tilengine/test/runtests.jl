# push!(LOAD_PATH, joinpath(@__DIR__, "Tilengine"))
# include("tilengine/tilengine.jl")
import Tilengine.Setup as s
import Tilengine.Bitmaps as bmaps
import Tilengine.Layers as layers
import Tilengine.Windowing as win

e = s.init(320, 224, 1, 1, 1)
bitmap = bmaps.loadBitmap("elis2.png")
bmaps.setBitmap(0, bitmap)
win.createWindow("", win.CWF_S2 | win.CWF_VSYNC)
win.setWindowTitle("Tilengine with Julia!")

function myRaster(line::Int32, data)
    layers.setLayerPosition(0, sin((float(line) + data) / (2 * pi * 2)) * 8, 0)
    return
end
off = 0.0
s.setRasterCallback(myRaster, off)

while win.processWindow()
    global off += 0.25
    s.setRasterData(off)
    win.drawFrame(0)
end
