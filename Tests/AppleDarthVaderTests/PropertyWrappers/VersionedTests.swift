//
//  VersionedTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

class ExpenseReport {
    enum State { case submitted, received, approved, denied }

    @Versioned var state: State = .submitted
}

struct VersionedTests {
    @Test func test() {
        let testSuit = ExpenseReport()

        testSuit.state = .denied
        testSuit.state = .approved
    }
}
