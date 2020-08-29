// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleConstraints",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "SimpleConstraints", targets: ["SimpleConstraints"]),
    ],
    targets: [
        .target(name: "SimpleConstraints", dependencies: []),
        .testTarget(name: "SimpleConstraintsTests", dependencies: ["SimpleConstraints"]),
    ]
)
