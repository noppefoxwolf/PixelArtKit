import XCTest
import BitmapContext
import Floodfill
@testable import PixelArtKit

final class FloodfillTests: XCTestCase {
    func testRGBA() throws {
        var context = BitmapContext<RGBAColorSpace>(width: 128, height: 128)
        context.addPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 64, height: 64)).cgPath)
        context.setStrokeColor(RGBAColor(red: 255, green: 0, blue: 0, alpha: 255))
        context.strokePath()
        let floodFillColor = RGBAColor(red: 255, green: 0, blue: 0, alpha: 255)
        context.addFloodFillPath(at: .init(x: 32, y: 32), fillColor: floodFillColor)
        context.setFillColor(RGBAColor(red: 0, green: 0, blue: 255, alpha: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/color_floodfill", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
    
    func testGray() throws {
        var context = BitmapContext<GrayColorSpace>(width: 128, height: 128)
        context.addPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 64, height: 64)).cgPath)
        context.setStrokeColor(GrayColor(gray: 255))
        context.strokePath()
        let floodFillColor = GrayColor(gray: 255)
        context.addFloodFillPath(at: .init(x: 32, y: 32), fillColor: floodFillColor)
        context.setFillColor(GrayColor(gray: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/gray_floodfill", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
}
