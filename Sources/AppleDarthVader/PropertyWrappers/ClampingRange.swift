//
//  ClampingRange.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

@propertyWrapper
public struct ClampingRange<Value: Comparable> {
    private var value: Value
    private let range: ClosedRange<Value>

    public var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }

    /// 指定属性值边界的包装器 @ClampingRange(0...14) var pH: Double = 7
    /// - Parameters:
    ///   - wrappedValue: 初始值
    ///   - range: 限定范围
    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        value = wrappedValue
        self.range = range
    }
}
