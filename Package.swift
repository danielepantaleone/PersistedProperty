// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistedProperty",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "PersistedProperty",
            targets: ["PersistedProperty"])
    ],
    targets: [
        .target(
            name: "PersistedProperty",
            dependencies: [],
            resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(
            name: "PersistedPropertyTests",
            dependencies: ["PersistedProperty"])
    ]
)
