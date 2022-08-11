@_spi(BitmapExtension) import BitmapContext
import CoreImage

extension BitmapLayer {
    public func makeImage(_ colorMapContext: BitmapContext<RGBAColorSpace>) -> BitmapImage? where ColorSpaceType == GrayColorSpace {
        guard let inputImage = self.makeImage() else { return nil }
        guard let colorMapImage = colorMapContext.makeImage() else { return nil }
        let filter = IndexColorFilter()
        filter.inputImage = CIImage(bitmap: inputImage)
        filter.colorMapImage = CIImage(bitmap: colorMapImage)
        guard let output = filter.outputImage else { return nil }
        
        let ciContext = CIContext(options: [
            .outputColorSpace : colorMapImage.colorSpace!,
        ])
        guard let cgImage = ciContext.createCGImage(output, from: output.extent) else {
            return nil
        }
        return BitmapImage(image: cgImage)
    }
}
