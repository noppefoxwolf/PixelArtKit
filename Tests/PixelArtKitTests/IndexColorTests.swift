import XCTest
@testable import PixelArtKit
@testable import IndexColor

final class IndexColorTests: XCTestCase {
    func testShader() {
        var colorMapContext = BitmapContext<RGBAColorSpace>(width: 16, height: 16)
        colorMapContext[index: 0] = RGBAColor(red: 0, green: 0, blue: 255, alpha: 255)
        colorMapContext[index: 255] = RGBAColor(red: 0, green: 255, blue: 0, alpha: 255)
        
        let context = BitmapContext<GrayColorSpace>(width: 128, height: 128)
        let layer = BitmapLayer(context: context)
        layer.setFillColor(GrayColor(gray: 255))
        layer.addPath(CGPath(rect: CGRect(x: 20, y: 20, width: 20, height: 20), transform: nil))
        layer.fillPath()
        
        let image = UIImage(bitmap: layer.makeImage(colorMapContext)!)
        let diff = UIImage(named: "Resource/index_color", in: .module, with: nil)!
    
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
}
