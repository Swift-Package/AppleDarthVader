//
//  StringExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation
import RegexBuilder

public extension String {
    /// 是不是email格式
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return predicate.evaluate(with: self)
        // let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        // let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }

    /// 打乱字符串
    /// - Returns: 打乱后的新字符串
    func garbled() -> String {
        String(shuffled())
    }

    /// 将字符串分割成由等长子字符串组成的数组
    /// - Parameter length: 子字符串长度
    /// - Returns: 子字符串组成的数组
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < endIndex {
            let endIndex = index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex ..< endIndex])
            startIndex = endIndex
        }
        return results.map { String($0) }
    }

    /// 在一个字符串中查找浮点数 - WWDC25 - Xcode 新功能 (Apple官方演示的实现没有try!)
    /// - Returns: 找到的浮点数结果集
    func scanForFloatingPointNumbers() -> [Regex<Substring>.Match] {
        return try! matches(of: Regex("/[+-]?[0-9]*[.][0-9]+/"))
    }
}
