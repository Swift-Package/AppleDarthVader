//
//  CapitalizedTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

private struct People {
    @Capitalized var name: String
}

struct CapitalizedTests {
    @Test func test() async throws {
        var p = People(name: "ss")
        #expect(p.name == "Ss")

        p.name = "cc"
        #expect(p.name == "Cc")
    }
}
