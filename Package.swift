// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PixelArtKit",
    platforms: [.iOS("16")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PixelArtKit",
            targets: ["PixelArtKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/noppefoxwolf/swift-line-algorithms", from: "0.0.2"),
        .package(url: "https://github.com/noppefoxwolf/BitmapContext", from: "0.0.5"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "PixelArtKit",
            dependencies: [
                .product(name: "LineAlgorithms", package: "swift-line-algorithms"),
                "Floodfill"
            ]
        ),
        .target(
            name: "Floodfill",
            dependencies: [
                .product(name: "DequeModule", package: "swift-collections"),
                "BitmapContext"
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
