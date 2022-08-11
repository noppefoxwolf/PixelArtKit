import XCTest
import BitmapContext
import Floodfill
@testable import PixelArtKit

final class DrawTests: XCTestCase {
    func testColorLine() throws {
        let context = BitmapContext<RGBAColorSpace>(width: 128, height: 128)
        context.addIntegerLinePath(Rect(x: 10, y: 10, width: 100, height: 100))
        context.setFillColor(RGBAColor(red: 255, green: 0, blue: 0, alpha: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/color_line", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
    
    func testGrayLine() throws {
        let context = BitmapContext<GrayColorSpace>(width: 128, height: 128)
        context.addIntegerLinePath(Rect(x: 10, y: 10, width: 100, height: 100))
        context.setFillColor(GrayColor(gray: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/gray_line", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
    
    func testColorEllipse() throws {
        let context = BitmapContext<RGBAColorSpace>(width: 128, height: 128)
        context.addIntegerEllipsePath(Rect(x: 10, y: 10, width: 100, height: 100))
        context.setFillColor(RGBAColor(red: 255, green: 0, blue: 0, alpha: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/color_ellipse", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
    
    func testGrayEllipse() throws {
        let context = BitmapContext<GrayColorSpace>(width: 128, height: 128)
        context.addIntegerEllipsePath(Rect(x: 10, y: 10, width: 100, height: 100))
        context.setFillColor(GrayColor(gray: 255))
        context.fillPath()
        let image = UIImage(bitmap: context.makeImage()!)
        let diff = UIImage(named: "Resource/gray_ellipse", in: .module, with: nil)!
        XCTAssertEqual(image.pngData()!, diff.pngData()!)
    }
}
