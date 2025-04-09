// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package.
import PackageDescription
import Foundation

// Set SKIP_ZERO=1 to build without Skip libraries
let zero = ProcessInfo.processInfo.environment["SKIP_ZERO"] != nil
let skipstone = !zero ? [Target.PluginUsage.plugin(name: "skipstone", package: "skip")] : []

let package = Package(
    name: "skipapp-hello",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "HelloSkip", type: .dynamic, targets: ["HelloSkip"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "HelloSkip", dependencies: (zero ? [] : [
            .product(name: "SkipUI", package: "skip-ui")
        ]), resources: [.process("Resources")], plugins: skipstone),
        .testTarget(name: "HelloSkipTests", dependencies: [
            "HelloSkip"] + (zero ? [] : [.product(name: "SkipTest", package: "skip")]), resources: [.process("Resources")], plugins: skipstone),
    ]
)
