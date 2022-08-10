import CoreGraphics
import LineAlgorithms

extension CGContext {
    public func addIntegerLinePath(_ rect: CGRect) {
        let standardizedRect = rect.standardized
        let from = SIMD2<Int>(
            x: Int(standardizedRect.minX),
            y: Int(standardizedRect.minY)
        )
        let to = SIMD2<Int>(
            x: Int(standardizedRect.maxX),
            y: Int(standardizedRect.maxY)
        )
        for point in SIMD2<Int>.protLine(from: from, to: to) {
            let origin = CGPoint(x: point.x, y: point.y)
            let size = CGSize(width: 1, height: 1)
            let rect = CGRect(origin: origin, size: size)
            addPath(CGPath(rect: rect, transform: nil))
        }
    }
    
    public func addIntegerEllipsePath(_ rect: CGRect) {
        let standardizedRect = rect.standardized
        let from = SIMD2<Int>(
            x: Int(standardizedRect.minX),
            y: Int(standardizedRect.minY)
        )
        let to = SIMD2<Int>(
            x: Int(standardizedRect.maxX),
            y: Int(standardizedRect.maxY)
        )
        for point in SIMD2<Int>.plotEllipse(from: from, to: to) {
            let origin = CGPoint(x: point.x, y: point.y)
            let size = CGSize(width: 1, height: 1)
            let rect = CGRect(origin: origin, size: size)
            addPath(CGPath(rect: rect, transform: nil))
        }
    }
}
