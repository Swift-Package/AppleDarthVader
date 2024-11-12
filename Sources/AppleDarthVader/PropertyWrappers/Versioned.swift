//
//  Versioned.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

@propertyWrapper
public struct Versioned<Value> {
    private var value: Value

    private(set) var timestampedValues: [(Date, Value)] = []

    public var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            timestampedValues.append((Date(), value))
        }
    }

    /// 属性变化时可以记录变化历史的包装器
    /// - Parameter wrappedValue: 默认值
    public init(wrappedValue: Value) {
        value = wrappedValue
    }
}
