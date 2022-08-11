import CoreGraphics
import BitmapContext
import LineAlgorithms

extension BitmapContext {
    public func addIntegerLinePath(_ rect: Rect) {
        let standardizedRect = rect.cgRect.standardized
        let from = SIMD2<Int>(
            x: Int(standardizedRect.minX),
            y: Int(standardizedRect.minY)
        )
        let to = SIMD2<Int>(
            x: Int(standardizedRect.maxX),
            y: Int(standardizedRect.maxY)
        )
        let path = CGMutablePath()
        for point in SIMD2<Int>.protLine(from: from, to: to) {
            let origin = CGPoint(x: point.x, y: point.y)
            let size = CGSize(width: 1, height: 1)
            let rect = CGRect(origin: origin, size: size)
            path.addRect(rect)
        }
        addPath(path.flattened(threshold: 0))
    }
    
    public func addIntegerEllipsePath(_ rect: Rect) {
        let standardizedRect = rect.cgRect.standardized
        let from = SIMD2<Int>(
            x: Int(standardizedRect.minX),
            y: Int(standardizedRect.minY)
        )
        let to = SIMD2<Int>(
            x: Int(standardizedRect.maxX),
            y: Int(standardizedRect.maxY)
        )
        let path = CGMutablePath()
        for point in SIMD2<Int>.plotEllipse(from: from, to: to) {
            let origin = CGPoint(x: point.x, y: point.y)
            let size = CGSize(width: 1, height: 1)
            let rect = CGRect(origin: origin, size: size)
            path.addRect(rect)
        }
        addPath(path.flattened(threshold: 0))
    }
}
