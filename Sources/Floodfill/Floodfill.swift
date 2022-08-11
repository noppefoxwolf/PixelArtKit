import CoreGraphics
import DequeModule
import BitmapContext
import UIKit

extension BitmapContext {
    public mutating func addFloodFillPath(
        at startPoint: Point,
        fillColor: ColorSpaceType.ColorType
    ) {
        guard let originalColor: ColorSpaceType.ColorType = self[point: startPoint] else { return }
        
        let fillPath: CGMutablePath = CGMutablePath()
        
        func getColor(at point: Point) -> ColorSpaceType.ColorType {
            // workaround: pathのcontainsは右下も含まれる判定になるので半ドットズラして確認する
            let cgPoint = point.cgPoint.applying(CGAffineTransform(translationX: 0.5, y: 0.5))
            return fillPath.contains(cgPoint, using: .winding) ? fillColor : self[point: point]!
        }
        
        defer {
            addPath(fillPath.flattened(threshold: 0))
        }
        
        var points = Deque<Point>()
        
        points.append(startPoint)

        var color: ColorSpaceType.ColorType
        var spanLeft: Bool
        var spanRight: Bool

        while var point = points.popLast() {
            color = getColor(at: point)

            while point.y >= 0 && originalColor == color {
                point.y -= 1
                if point.y >= 0 {
                    color = getColor(at: point)
                }
            }
            point.y += 1

            spanLeft = false
            spanRight = false

            color = getColor(at: point)

            while point.y < height && originalColor == color && fillColor != color {
                let rect = CGRect(origin: point.cgPoint, size: CGSize(width: 1, height: 1))
                let path = CGPath(rect: rect, transform: nil)
                fillPath.addPath(path)

                if point.x > 0 {
                    color = getColor(at: Point(x: point.x - 1, y: point.y))

                    if !spanLeft && point.x > 0 && originalColor == color {
                        points.append(Point(x: point.x - 1, y: point.y))
                        spanLeft = true
                    } else if spanLeft && point.x > 0 && originalColor != color {
                        spanLeft = false
                    }
                }

                if point.x < width - 1 {
                    color = getColor(at: Point(x: point.x + 1, y: point.y))

                    if !spanRight && originalColor == color {
                        points.append(Point(x: point.x + 1, y: point.y))
                        spanRight = true
                    } else if spanRight && originalColor != color {
                        spanRight = false
                    }
                }

                point.y += 1

                if point.y < height {
                    color = getColor(at: point)
                }
            }
        }
    }
}
