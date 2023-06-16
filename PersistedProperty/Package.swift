// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistedProperty",
    products: [
        .library(
            name: "PersistedProperty",
            targets: ["PersistedProperty"]),
    ],
    targets: [
        .target(
            name: "PersistedProperty",
            dependencies: []),
        .testTarget(
            name: "PersistedPropertyTests",
            dependencies: ["PersistedProperty"]),
    ]
)
