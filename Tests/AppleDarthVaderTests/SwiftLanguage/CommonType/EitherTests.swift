//
//  EitherTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

struct EitherTests {
    @Test func test() {
        let ei = Either<String, Int>.right(2).map { $0 * $0 }
        print("EitherTests \(ei)")
    }
}
