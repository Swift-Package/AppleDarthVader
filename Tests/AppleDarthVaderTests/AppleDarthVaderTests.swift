@testable import AppleDarthVader
@testable import AppleDarthVaderOC
import Testing
import XCTest

struct AppleDarthVaderTests {
    @Test("测试Core Foundation字节序转换工具函数") func example() {
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
}
