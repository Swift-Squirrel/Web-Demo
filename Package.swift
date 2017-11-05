// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "WebTemplate",
    products: [
        .executable(
            name: "WebTemplate",
            targets: ["WebTemplate"])
    ],
    dependencies: [
        .package(url: "https://github.com/Swift-Squirrel/Squirrel", from: "0.3.0"),
        .package(url: "https://github.com/Swift-Squirrel/NutView.git", from: "0.2.3")
    ],
    targets: [
        .target(
            name: "WebTemplate",
            dependencies: ["Squirrel", "NutView"])
    ]
)
