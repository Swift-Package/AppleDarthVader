//
//  DataBinaryTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/8.
//

@testable import AppleDarthVader
import Foundation
import Testing

struct DataBinaryTests {
    @Test("测试Data的二进制表示") func test() {
        let data = Data([0x7C, 0xAB])

        #expect(data.binary() == "0111110010101011")
    }
}
