// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppleDarthVader",
    defaultLocalization: "zh",
    platforms: [.iOS(.v18), .macOS(.v15), .watchOS(.v11), .tvOS(.v18), .visionOS(.v2)],
    products: [
        // MARK: - 纯Swift库
        .library(name: "AppleDarthVader", targets: ["AppleDarthVader"]),
        // MARK: - 纯Objective-C库
        .library(name: "AppleDarthVaderOC", targets: ["AppleDarthVaderOC"])
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", branch: "master"),
        .package(url: "https://github.com/ReactiveX/RxSwift", branch: "main"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "main"),// 代码格式化工具 - 在AppleDarthVader上下文菜单中使用SwiftFormatPlugin
    ],
    targets: [
        // MARK: - 纯Swift目标 - 依赖纯Objective-C目标以复用Objective-C代码
        .target(name: "AppleDarthVader",
                dependencies: ["Then",
                               "RxSwift",
                               .target(name: "AppleDarthVaderOC"),
                               .product(name: "RxCocoa", package: "RxSwift"),
                              ],
                exclude: [],
                resources: [.copy("FoundationDevelop/Bundle/Projects.json")],
                swiftSettings: [.swiftLanguageMode(.v5),
                                // .unsafeFlags(["-suppress-warnings"]),// 压制所有编译警告
                                .define("PACKAGECONFIGURATION_DEBUG", .when(configuration: .debug)),
                                .define("PACKAGECONFIGURATION_RELEASE", .when(configuration: .release)),
                               ]
                // linkerSettings: [.linkedFramework("CFNetwork", .when(platforms: [.iOS], configuration: nil))]
               ),
        // MARK: - 纯Objective-C目标
        .target(name: "AppleDarthVaderOC",
                dependencies: [],
                path: "Sources/AppleDarthVaderOC",
                exclude: [],
                resources: [],
                publicHeadersPath: "",
                cSettings: []),
                // cSettings: [.unsafeFlags(["-w"])]),// 压制所有编译警告
        // MARK: - 纯Swift测试目标用来测试两个库(逐步迁移到Swift Testing框架)
        .testTarget(name: "AppleDarthVaderTests",
                    dependencies: ["AppleDarthVader",
                                   "AppleDarthVaderOC",
                                  ],
                    exclude: [],
                    resources: [.copy("Resources/DarthVader.png"),
                                .copy("FoundationDevelop/Bundle/WeatherbitExample.json"),],
                    swiftSettings: [.swiftLanguageMode(.v5)]),
        // MARK: - 纯Objective-C测试目标用来测试两个库
        .testTarget(name: "AppleDarthVaderOCTests",
                    dependencies: ["AppleDarthVader",
                                   "AppleDarthVaderOC"
                                  ],
                    exclude: [],
                    resources: [],
                    cSettings: [])
    ],
    swiftLanguageModes: [.v6, .v5]
)
