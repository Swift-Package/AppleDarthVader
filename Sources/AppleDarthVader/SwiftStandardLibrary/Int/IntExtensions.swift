//
//  IntExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Int {
    /// 是否偶数
    var isEven: Bool { isMultiple(of: 2) }
}

public extension Int {
    /// 罗马数字字符串表示
    var romanNumeral: String {
        RomanNumeralConverter().convert(self)
    }
}
