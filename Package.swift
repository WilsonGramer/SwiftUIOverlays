// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUIOverlays",
    platforms: [.iOS("14.0")],
    products: [
        .library(
            name: "SwiftUIOverlays",
            targets: ["SwiftUIOverlays"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIOverlays",
            dependencies: []
        ),
    ]
)
