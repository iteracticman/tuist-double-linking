@preconcurrency import ProjectDescription

let project = Project(
    name: "TuistPackageLinkingTest",
    options: .options(),
    targets: [
        .target(
            name: "TuistPackageLinkingTest",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.TuistPackageLinkingTest",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["TuistPackageLinkingTest/Sources/**"],
            resources: ["TuistPackageLinkingTest/Resources/**"],
            dependencies: [
                .target(name: "Feature")
            ]
        ),
        .target(
            name: "Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "feature",
            sources: ["Feature/Sources/**"],
            dependencies: [
                .target(name: "FeatureService")
            ]
        ),
        .target(
            name: "FeatureService",
            destinations: .iOS,
            product: .framework,
            bundleId: "featureservice",
            sources: ["FeatureService/Sources/**"],
            dependencies: [
                .target(name: "CoreService")
            ]
        ),
        .target(
            name: "CoreService",
            destinations: .iOS,
            product: .framework,
            bundleId: "coreservice",
            sources: ["CoreService/Sources/**"],
            dependencies: [
                .target(name: "Core")
            ]
        ),
        .target(
            name: "Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "core",
            sources: ["Core/Sources/**"],
            dependencies: [
                .external(name: "Alamofire"),
                .external(name: "HTTPTypesFoundation"),
            ]
        ),
    ]
)
