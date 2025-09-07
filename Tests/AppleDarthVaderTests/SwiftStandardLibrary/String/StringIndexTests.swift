//
//  StringIndexTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Testing

struct StringIndexTests {
    @Test func stringIndex() {
        let string = "Hello, Swift!"
        let secondChar = string[1]
        #expect(secondChar == "e")
    }
}
