//
//  ArrayOpaqueTypesTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing
import XCTest

struct ArrayOpaqueTypesTests {
    @Test func test() {
        let ss = ["1", "2", "3x", "4"].transformToInts()
        for i in ss {
            print(i)
        }

        #expect(ss.contains(where: { element in
            element as! Int == 2
        }))
    }
}
