// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        productTypes: ["Alamofire": .staticFramework]
    )
#endif

let package = Package(
    name: "TuistPackageLinkingTest",
    dependencies: [
         .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
         .package(url: "https://github.com/apple/swift-http-types.git", from: "1.4.0")
    ]
)
