//
//  CollectionProtocolTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/5.
//

import Testing
@testable import AppleDarthVader

struct CollectionProtocolTests {
    @Test func test() async throws {
		let numbers = [1, 2, 3, 4]
		#expect(!numbers.containsDuplicates())
		
		let numbers1 = [1, 2, 3, 4, 1]
		#expect(numbers1.containsDuplicates())
    }
}
