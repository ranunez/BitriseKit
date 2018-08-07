// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BitriseKit",
    products: [
        .library(name: "BitriseKit", targets: ["BitriseKit"])
    ],
    targets: [
    .target(name: "BitriseKit", path: "BitriseKit")
    ]
)
