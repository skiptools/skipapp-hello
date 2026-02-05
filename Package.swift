// swift-tools-version: 6.1
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "skipapp-hello",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "HelloSkip", type: .dynamic, targets: ["HelloSkip"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.7.1"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "HelloSkip", dependencies: [
            .product(name: "SkipUI", package: "skip-ui")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "HelloSkipTests", dependencies: [
            "HelloSkip",
            .product(name: "SkipTest", package: "skip")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

// Setting the SKIP_ZERO=1 environment will strip out the Skip plugin and all Skip dependencies
if Context.environment["SKIP_ZERO"] ?? "0" != "0" {
    package.targets.forEach { target in
        // remove the Skip plugin
        target.plugins?.removeAll(where: {
            if case .plugin(let name, _) = $0 {
                return name == "skipstone"
            } else {
                return false
            }
        })

        // remove the Skip target dependencies
        target.dependencies.removeAll(where: { dependency in
            if case .productItem(_, let package, _, _) = dependency {
                return package == "skip" || package?.hasPrefix("skip-") == true
            } else {
                return false
            }
        })
    }

    // remove the Skip package dependencies
    package.dependencies.removeAll(where: { dependency in
        if case .sourceControl(_, let url, _) = dependency.kind {
            return url.hasPrefix("https://source.skip.dev/") || url.hasPrefix("https://source.skip.tools/")
        } else {
            return false
        }
    })
}
