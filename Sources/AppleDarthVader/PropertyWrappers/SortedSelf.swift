//
//  SortedSelf.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

/// 指定KeyPath排序规则的数组属性包装器
@propertyWrapper
public struct SortedSelf<Element, SortProperty: Comparable> {
    private var array: [Element] = []
    private let sortProperty: KeyPath<Element, SortProperty>

    public var wrappedValue: [Element] {
        get { return array }
        set { array = newValue.sorted(by: { $0[keyPath: sortProperty] < $1[keyPath: sortProperty] }) }
    }

    public init(wrappedValue: [Element], by sortProperty: KeyPath<Element, SortProperty>) {
        self.sortProperty = sortProperty
        self.wrappedValue = wrappedValue
    }
}
