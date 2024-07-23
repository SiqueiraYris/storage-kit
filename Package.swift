// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorageKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [ .iOS(.v12) ],
    products: [
        .library(
            name: "StorageKit",
            targets: ["StorageKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StorageKit",
            dependencies: [],
            resources: [
                .process("Utils/Resources/PrivacyInfo.xcprivacy")
            ]),
        .testTarget(
            name: "StorageKitTests",
            dependencies: ["StorageKit"])
    ]
)
