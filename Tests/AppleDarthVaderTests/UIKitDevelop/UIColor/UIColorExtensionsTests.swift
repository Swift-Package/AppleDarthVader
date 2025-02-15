//
//  UIColorExtensionsTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/10.
//

@testable import AppleDarthVader
import Testing
import UIKit

struct UIColorExtensionsTests {
    @Test func test() async throws {
        let colors = [
            UIColor(hex: "#cafe00"),
            UIColor(hex: "cafe00"),
            UIColor(hex: "c"),
            UIColor(hex: "ca"),
            UIColor(hex: "caf"),
            UIColor(hex: 0xCAFE00),
        ]
        let values = colors.map { $0.hexValue }
        #expect(values == ["#CAFE00", "#CAFE00", "#CCCCCC", "#CACACA", "#CCAAFF", "#CAFE00"])
    }
}
