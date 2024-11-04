//
//  TrimmedTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

struct Post {
    @Trimmed var title: String
}

struct TrimmedTests {
    @Test func test() {
        #expect(Post(title: " cccc ").title == "cccc")
    }
}
