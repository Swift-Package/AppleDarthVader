//
//  OptionalExtesionsTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/13.
//

import Testing
@testable import AppleDarthVader

struct OptionalExtesionsTests {

	// MARK: - 简单测试可选类型便利解包 unwrapped(or:) - 20251113
    @Test func test() {
		let a: Int? = nil
		let b = a.unwrapped(or: 10)
		#expect(b == 10)
		
		let name: String? = nil
		let result = name.unwrapped(or: "默认值")
		#expect(result == "默认值")
    }
}
