// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppleDarthVader",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v26), .watchOS(.v26), .tvOS(.v26), .visionOS(.v26)],
    products: [
        // MARK: - 纯 Swift 库
        .library(name: "AppleDarthVader", targets: ["AppleDarthVader"]),
        // MARK: - 纯 Objective-C 库
        .library(name: "AppleDarthVaderOC", targets: ["AppleDarthVaderOC"]),
        // MARK: - 纯 C 库
        .library(name: "PureCLibrary", targets: ["PureCLibrary"]),
        // MARK: - WWDC 演示代码汇总不对外提供扩展
        .library(name: "WWDCEsoterica", targets: ["WWDCEsoterica"]),
        // MARK: - 持续进化学习笔记不对外提供扩展
        .library(name: "ContinuousEvolution", targets: ["ContinuousEvolution"]),
    ],
    dependencies: [
        .package(url: "https://github.com/devxoul/Then", branch: "master"),
        .package(url: "https://github.com/ReactiveX/RxSwift", branch: "main"),
//        .package(url: "https://github.com/SnapKit/SnapKit", branch: "develop"),
//        .package(url: "https://github.com/airbnb/lottie-ios", branch: "master"),
//        .package(url: "https://github.com/SDWebImage/SDWebImage", branch: "master"),
//        .package(url: "https://github.com/AFNetworking/AFNetworking", branch: "master"),
//        .package(url: "https://github.com/pointfreeco/swift-navigation", branch: "main"),
//        .package(url: "https://github.com/SVProgressHUD/SVProgressHUD", branch: "master"),
//        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager", branch: "master"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", branch: "main"),// 代码格式化工具 - 在AppleDarthVader上下文菜单中使用SwiftFormatPlugin
    ],
    targets: [
        // MARK: - 纯 Swift 目标 - 依赖纯 Objective-C 目标以复用 Objective-C 代码
        .target(name: "AppleDarthVader",
                dependencies: [
                    "Then",
                    "RxSwift",
                    .target(name: "AppleDarthVaderOC"),
                    .product(name: "RxCocoa", package: "RxSwift"),
                ],
                exclude: [],// 需要排除的文件
                resources: [
                    .copy("FoundationDevelop/Bundle/Projects.json")
                ],
                swiftSettings: [
                    .swiftLanguageMode(.v6),
                    .unsafeFlags([
                        "-Xfrontend",
                        "-warn-long-function-bodies=1000",
                        "-Xfrontend",
                        "-warn-long-expression-type-checking=1000"
                    ]),
                    //.treatAllWarnings(as: .error)
                    //.treatWarning("StrictMemorySafety", as: .error),
                    // .unsafeFlags(["-suppress-warnings"]),// 压制所有编译警告
                    .define("PACKAGECONFIGURATION_DEBUG", .when(configuration: .debug)),
                    .define("PACKAGECONFIGURATION_RELEASE", .when(configuration: .release)),
                ]
                // linkerSettings: [.linkedFramework("CFNetwork", .when(platforms: [.iOS], configuration: nil))]
               ),
        // MARK: - 纯 Objective-C 库
        .target(name: "AppleDarthVaderOC",
                dependencies: [],
                path: "Sources/AppleDarthVaderOC",
                exclude: [],
                resources: [],
                publicHeadersPath: ".",// 公共头文件的路径设置为当前目录
                cSettings: []),
                // cSettings: [.unsafeFlags(["-w"])]),// 压制所有编译警告
        // MARK: - 纯 C 库
        .target(name: "PureCLibrary",
                dependencies: [],
                path: "Sources/PureCLibrary",
                exclude: [],
                resources: [],
                cSettings: [
                    .define("SHOW_DEBUG_INFO", to: "1")
                ]),
        // MARK: - WWDC 演示代码汇总
        .target(name: "WWDCEsoterica",
                swiftSettings: [.swiftLanguageMode(.v6)]),
        // MARK: - 持续进化学习笔记
        .target(name: "ContinuousEvolution",
                dependencies: [],
                exclude: [],
                resources: [],
                swiftSettings: [
                    .swiftLanguageMode(.v6),
                    .unsafeFlags([
                        // "-strict-concurrency=complete",
                        "-Xfrontend",
                        "-warn-long-function-bodies=1000",
                        "-Xfrontend",
                        "-warn-long-expression-type-checking=1000",
                        // "-Xfrontend -disable-sendable-checks"
						// "-Xfrontend -disable-actor-isolation-checks",
                    ]),
                    // .enableUpcomingFeature("InternalImportsByDefault"),
                    .treatWarning("DeprecatedDeclaration", as: .error),
                    .define("PACKAGECONFIGURATION_DEBUG", .when(configuration: .debug)),
                    .define("PACKAGECONFIGURATION_RELEASE", .when(configuration: .release)),
                ]),
        // MARK: - 纯 Swift 测试目标用来测试两个库(逐步迁移到 Swift Testing 框架)
        .testTarget(name: "AppleDarthVaderTests",
                    dependencies: ["AppleDarthVader",
                                   "AppleDarthVaderOC",
                                  ],
                    exclude: [],
                    resources: [.copy("Resources/DarthVader.png"),
                                .copy("FoundationDevelop/Bundle/WeatherbitExample.json"),],
                    swiftSettings: [.swiftLanguageMode(.v6)]),
        // MARK: - 纯 Objective-C 测试目标用来测试两个库
        .testTarget(name: "AppleDarthVaderOCTests",
                    dependencies: ["AppleDarthVader",
                                   "AppleDarthVaderOC"
                                  ],
                    exclude: [],
                    resources: [],
                    cSettings: [],
                    swiftSettings: [.swiftLanguageMode(.v6)]),
        // MARK: - Combine 学习目标(通过 Swift Testing 框架测试 Combine 相关知识点)
        .testTarget(name: "CombineLearnTests",
                    dependencies: [],
                    exclude: [],
                    resources: [],
                    swiftSettings: [.swiftLanguageMode(.v6)]),
        // MARK: - 纯 Swift 测试纯 C 库
        .testTarget(name: "PureCLibraryTests",
                    dependencies: ["PureCLibrary"],
                    exclude: [],
                    resources: [],
                    swiftSettings: [.swiftLanguageMode(.v6)]),
    ],
    swiftLanguageModes: [.v6]
)
//public final class TouchUISwitchRequest: Request {
//    
//    public private(set) var touchOn: Bool
//    
//    public init(_ touchOn: Bool) {
//        self.touchOn = touchOn
//        super.init(Command.COMMAND_TOUCH_UI)
//    }
//    
//    public override func getPayload() -> Data {
//        let value: UInt8 = touchOn ? 0x01 : 0x00
//        return Data([value])
//    }
//}

//extension Command {
//    // 新增
//    public static let COMMAND_TOUCH_UI: UInt8           = 0x33 // TouchUI
//}
// MARK: - https://www.youtube.com/watch?v=k90TKBVjo9c
//// MARK: - 开放封闭原则
//struct OpenAnalyticEvent {
//    let name: String
//    
//    static let viewLoaded: Self = .init(name: "viewLoaded")
//}
//extension OpenAnalyticEvent {
//    static let btnTap = OpenAnalyticEvent(name: "btnTap")
//}

//#if hasFeature(InternalImportByDefault)
//fileprivate import ContinuousEvolution
//#else
//import ContinuousEvolution
//#endif
