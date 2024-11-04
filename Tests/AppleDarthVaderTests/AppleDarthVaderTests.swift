@testable import AppleDarthVader
import Testing
import XCTest

@Test func example() {
    XCTAssertTrue(CFByteOrderGetCurrent() != 0)

    XCTAssertEqual(CFSwapInt32HostToBig(305_419_896), 2_018_915_346)
    XCTAssertEqual(CFSwapInt32HostToLittle(4_043_309_055), 4_043_309_055)
    XCTAssertEqual(CFSwapInt32HostToBig(4_043_309_055), 4_294_967_280)
    XCTAssertEqual(CFSwapInt32HostToBig(0xF0FF_FFFF), 0xFFFF_FFF0)

    let version: [UInt8] = [0, 0, 0]
    XCTAssertEqual(MemoryLayout.size(ofValue: version), 8)
    XCTAssertEqual(MemoryLayout<UInt8>.size, 1)
    XCTAssertEqual(MemoryLayout<[UInt8]>.size, 8)
    XCTAssertEqual(MemoryLayout.size(ofValue: [0, 0, 0]), 8)
    // f0ff ffff
    // ffff fff0
}
