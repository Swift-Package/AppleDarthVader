//
//  ArrayParallelForEachTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.youtube.com/watch?v=PvIl4vugytc

@testable import AppleDarthVader
import XCTest

final class ArrayParallelForEachTests: XCTestCase {
    func testExample() throws {
        for element in [1, 2, 3, 4, 5] {
            let result = (0 ... element).reduce(0, +)
            print("非性能测试不会重复执行Element \(element) reduce结果 \(result)")
        }
    }

    func testPerformanceExample() throws {
        print("性能测试会重复执行10次")
        measure {
            for element in Array(1 ... 2000) {
                let result = (0 ... element).reduce(0, +)
                print("Element \(element) reduce结果 \(result)")
            }
        }
    }

    func testParallelPerformance() throws {
        print("并行性能测试会重复执行10次")
        measure {
            Array(1 ... 2000).parallelForEach { element in
                let result = (0 ... element).reduce(0, +)
                print("Element \(element) reduce结果 \(result)")
            }
        }
    }
}
