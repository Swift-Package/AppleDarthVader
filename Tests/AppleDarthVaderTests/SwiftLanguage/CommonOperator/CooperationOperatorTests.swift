//
//  CooperationOperatorTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

struct CooperationOperatorTests {
    @Test func test() {
        func incr(x: Int) -> Int { return x + 1 }
        func squ(x: Int) -> Int { return x * x }

        let function = (incr >>> squ) >>> incr
        let result = Array(1 ... 10).map(function)
        print(result)
    }
}
