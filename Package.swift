// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PixelArtKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "PixelArtKit",
            targets: ["PixelArtKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/noppefoxwolf/swift-line-algorithms", from: "0.0.2"),
        .package(url: "https://github.com/noppefoxwolf/BitmapContext", from: "0.0.15"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "PixelArtKit",
            dependencies: [
                .product(name: "LineAlgorithms", package: "swift-line-algorithms"),
                "Floodfill",
                "DigitalLine",
                "IndexColor",
            ]
        ),
        .target(
            name: "Floodfill",
            dependencies: [
                .product(name: "DequeModule", package: "swift-collections"),
                "BitmapContext"
            ]
        ),
        .target(
            name: "DigitalLine",
            dependencies: [
                "BitmapContext"
            ]
        ),
        .target(
            name: "IndexColor",
            dependencies: [
                "BitmapContext"
            ],
            exclude: [
                "Shaders.metal"
            ],
            resources: [
                .copy("Shaders.metallib")
            ]
        ),
        .testTarget(
            name: "PixelArtKitTests",
            dependencies: [
                "PixelArtKit"
            ],
            resources: [
                .copy("Resource")
            ]
        )
    ]
)
