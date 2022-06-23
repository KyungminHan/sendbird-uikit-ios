// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SendBirdUIKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "SendBirdUIKit",
            targets: ["SendBirdUIKit"]
        ),
    ],
    dependencies: [
        .package(name: "SendBirdSDK", url: "https://github.com/sendbird/sendbird-ios-framework", .exact("3.1.13"))
    ],
    targets: [
        .target(
            name: "SendBirdUIKit",
            dependencies: ["SendBirdSDK"]
        ),
    ]
)
