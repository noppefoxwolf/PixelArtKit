import CoreImage
import CoreGraphics

class IndexColorFilter: CIFilter {
    let kernel: CIKernel = .lookupTable()
    // 8bit grayscale image
    var inputImage: CIImage?
    // 16x16 256 color palette
    var colorMapImage: CIImage?
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        guard let colorMapImage = colorMapImage else { return nil }
        let roiCallback: CIKernelROICallback = { index, rect -> CGRect in
            switch index {
            case 0:
                return inputImage.extent
            case 1:
                return CGRect(x: 0, y: 0, width: 16, height: 16)
            default:
                fatalError()
            }
        }
        return kernel.apply(
            extent: inputImage.extent,
            roiCallback: roiCallback,
            arguments: [inputImage, colorMapImage]
        )
    }
}

