//
//  PureCLibraryTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

@testable import PureCLibrary
import Testing

struct PureCLibraryTests {
    class A {
        var pr = 0

        func callCAdd() {
            pr = Int(add(12, 12))
        }
    }

    @Test func example() {
        let a = A()
        a.callCAdd()

        print("调用C函数相加 12 + 12 = " + "\(a.pr)")
    }
}
