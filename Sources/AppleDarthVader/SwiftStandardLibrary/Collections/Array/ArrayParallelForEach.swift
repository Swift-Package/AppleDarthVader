//
//  ArrayParallelForEach.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Array where Element: Sendable {
    /// 并行迭代数组中的各个元素
    /// - Parameter body: 迭代操作
    func parallelForEach(_ body: @Sendable (Element) -> Void) {
        DispatchQueue.concurrentPerform(iterations: count) { index in
            body(self[index])
        }
    }
}
