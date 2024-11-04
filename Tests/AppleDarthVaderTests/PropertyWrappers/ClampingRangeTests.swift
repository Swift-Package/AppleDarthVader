//
//  ClampingRangeTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

struct Solution {
    @ClampingRange(0 ... 14) var pH: Double = 7.0
}

struct ClampingRangeTests {
    @Test func test() {
        let s = Solution()

        #expect(s.pH == 7)

        var ss = Solution(pH: 6)
        #expect(ss.pH == 6)

        ss.pH = 99
        #expect(ss.pH == 14)
    }
}
