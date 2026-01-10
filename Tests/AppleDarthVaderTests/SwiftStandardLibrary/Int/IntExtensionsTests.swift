//
//  IntExtensionsTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/10.
//

import Testing
@testable import AppleDarthVader

struct IntExtensionsTests {
	
    @Test func test() {
		let x = 10
		let bix = x[bit: 3]
		#expect(bix == true)
		// 1010
    }
}
