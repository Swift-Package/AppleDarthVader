//
//  Trimmed.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

@propertyWrapper
public struct Trimmed {
    private(set) var value: String = ""

    public var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    /// 去除字符串前后空格
    /// - Parameter wrappedValue: 默认值
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
