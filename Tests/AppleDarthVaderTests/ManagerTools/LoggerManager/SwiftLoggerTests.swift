//
//  SwiftLoggerTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Foundation
import Testing

struct SwiftLoggerTests {
    private let timeFormatter = DateFormatter().then { make in
        make.dateFormat = "yyyy-MM-dd' 'HH:mm:ss.SSSS"
    }

    @Test("路标Signpost性能测试") func test() {
        // MARK: - 这里是使用示例但是代码耗时太长为了避免影响测试注释掉

        /*
         func testPerformanceExample() throws {
             self.measure {

                 var time = Date.init()
                 var timeStr = timeFormatter.string(from: time)
                 var timeAndURLStamp = timeStr.appending("cc")

                 SwiftSignposter.shared.signpostNetworkGetBeginWith(url: "cc", timeAndURLStamp: timeAndURLStamp as NSString)
                 for _ in 0...10000 {
                     for _ in 0...1000 {
                         print("DarthVader")
                     }
                 }
                 SwiftSignposter.shared.signpostNetworkGetEndWith(url: "cc", timeAndURLStamp: timeAndURLStamp as NSString)

                 time = Date.init()
                 timeStr = timeFormatter.string(from: time)
                 timeAndURLStamp = timeStr.appending("aa")

                 SwiftSignposter.shared.signpostNetworkPostBeginWith(url: "pp", timeAndURLStamp: timeAndURLStamp as NSString)
                 for _ in 0...10000 {
                     for _ in 0...1000 {
                         print("DarthVader")
                     }
                 }
                 SwiftSignposter.shared.signpostNetworkPostEndWith(url: "pp", timeAndURLStamp: timeAndURLStamp as NSString)

                 SwiftSignposter.shared.signpostFlashEventWith(id: 888)

                 time = Date.init()
                 timeStr = timeFormatter.string(from: time)
                 timeAndURLStamp = timeStr.appending("aa")

                 SwiftSignposter.shared.signpostNetworkGetBeginWith(url: "aa", timeAndURLStamp: timeAndURLStamp as NSString)
                 for _ in 0...10000 {
                     for _ in 0...1000 {
                         print("DarthVader")
                     }
                 }
                 SwiftSignposter.shared.signpostNetworkGetEndWith(url: "aa", timeAndURLStamp: timeAndURLStamp as NSString)

                 SwiftSignposter.shared.signpostFlashEventWith(id: 666)

                 SwiftSignposter.shared.signpostBeginWith(id: 123)
                 for _ in 0...10000 {
                     for _ in 0...1000 {
                         print("DarthVader")
                     }
                 }
                 SwiftSignposter.shared.signpostEndWith(id: 123)

                 SwiftSignposter.shared.signpostFlashEventWith(id: 777)
             }
         }*/
    }
}
