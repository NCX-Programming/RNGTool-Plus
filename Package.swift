// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RNGTool-Plus",
    dependencies: [
        .package(url: "https://github.com/stackotter/swift-cross-ui", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "RNGTool-Plus",
            dependencies: [
                .product(name: "SwiftCrossUI", package: "swift-cross-ui"),
                .product(name: "GtkBackend", package: "swift-cross-ui")
            ],
            resources: [
                .process("Assets/Dice/Light/Die1.svg"),
                .process("Assets/Dice/Light/Die2.svg"),
                .process("Assets/Dice/Light/Die3.svg"),
                .process("Assets/Dice/Light/Die4.svg"),
                .process("Assets/Dice/Light/Die5.svg"),
                .process("Assets/Dice/Light/Die6.svg"),
                .process("Assets/Dice/Dark/Die1-dark.svg"),
                .process("Assets/Dice/Dark/Die2-dark.svg"),
                .process("Assets/Dice/Dark/Die3-dark.svg"),
                .process("Assets/Dice/Dark/Die4-dark.svg"),
                .process("Assets/Dice/Dark/Die5-dark.svg"),
                .process("Assets/Dice/Dark/Die6-dark.svg")
            ]
        ),
        .testTarget(
            name: "RNGTool-PlusTests",
            dependencies: ["RNGTool-Plus"]),
    ]
)
