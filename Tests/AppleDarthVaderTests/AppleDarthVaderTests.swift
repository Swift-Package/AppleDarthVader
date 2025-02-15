@testable import AppleDarthVader
@testable import AppleDarthVaderOC
import Testing
import XCTest

@Suite(.serialized)
struct AppleDarthVaderTests {
    @Test("测试Core Foundation字节序转换工具函数", .tags(.format)) func example() {
        #expect(CFByteOrderGetCurrent() != 0)
        #expect(CFSwapInt32HostToBig(305_419_896) == 2_018_915_346)
        #expect(CFSwapInt32HostToLittle(4_043_309_055) == 4_043_309_055)
        #expect(CFSwapInt32HostToBig(4_043_309_055) == 4_294_967_280)
        #expect(CFSwapInt32HostToBig(0xF0FF_FFFF) == 0xFFFF_FFF0)

        let version: [UInt8] = [0, 0, 0]
        #expect(MemoryLayout<UInt8>.size == 1)
        #expect(MemoryLayout.size(ofValue: version) == 8)
        #expect(MemoryLayout<[UInt8]>.size == 8)
        #expect(MemoryLayout.size(ofValue: [0, 0, 0]) == 8)
        // f0ff ffff
        // ffff fff0
    }

    @Test("Bug标记", .bug("https://example.com/issues/9999", id: 9999, "Title")) func bufReport() {}

    @Test(.enabled(if: TestCondition.isOnline)) func enabledConditionTest() {}

    @Test(.disabled("Currently broken")) func skipTest() {}

    @Test("系统限制") @available(iOS 18, *) func system() {}

    @Test("时间性能", .timeLimit(.minutes(3))) func timeLimitTest() {}
}

// MARK: - 所有的测试标签

extension Tag {
    @Tag static var format: Self
}

enum TestCondition {
    static let isOnline = false
}
