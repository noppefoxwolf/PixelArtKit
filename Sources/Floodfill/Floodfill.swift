import CoreGraphics
import DequeModule
import BitmapContext

extension BitmapContext {
    public mutating func addFloodFillPath(
        at startPoint: Point,
        fillColor: ColorSpaceType.ColorType
    ) {
        guard let originalColor: ColorSpaceType.ColorType = self[point: startPoint] else { return }
        
        var filledPoint: Set<Point> = []
        func getColor(at point: Point) -> ColorSpaceType.ColorType {
            filledPoint.contains(point) ? fillColor : self[point: point]!
        }
        defer {
            for point in filledPoint {
                let rect = CGRect(origin: point.cgPoint, size: CGSize(width: 1, height: 1))
                addPath(CGPath(rect: rect, transform: nil))
            }
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
                //self[point: point] = fillColor
                filledPoint.insert(point)
                // traceContext?[point: point] = RGBAPixel.black

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
