//
//  OptionalExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Optional where Wrapped == String {}

// MARK: - 扩展可选类型便利解包- 20251112 神牛公司面试题
public extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        self ?? defaultValue
    }
}
