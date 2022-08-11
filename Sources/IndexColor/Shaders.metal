#include <metal_stdlib>
using namespace metal;
#include <CoreImage/CoreImage.h>

extern "C" { namespace coreimage {
    float4 lookupTable(sampler src, sampler lut) {
        float2 pos = src.coord();
        float4 pixelColor = src.sample(pos);
        int index = pixelColor.r * 255;
        int x = index % int(lut.size().x);
        int y = index / int(lut.size().y);
        float2 lutPos = float2(x, y);
        float4 lutColor = lut.sample(lutPos);
        return lutColor;
    }
}}
