// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CommonPlace",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "CommonPlace",
            targets: ["CommonPlace"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "CommonPlace",
            dependencies: [],
            path: "Sources")
    ]
)
