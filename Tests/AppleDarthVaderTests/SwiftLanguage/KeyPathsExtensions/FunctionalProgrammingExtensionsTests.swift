//
//  FunctionalProgrammingExtensionsTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

private struct People {
    var age: Int
}

struct FunctionalProgrammingExtensionsTests {
    @Test func test() {
        let peoples = [People(age: 18), People(age: 16)]

        #expect(peoples.filter(\.age > 18).count == 0)
    }
}
