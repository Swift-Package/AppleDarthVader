//
//  StringFormat.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension String {
    // MARK: - 必须在包的Target声明resources参数Bundle.module的定义才会生成

    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.module, value: self, comment: self)
    }

    func truncatedPrefix(_ maxLength: Int, using truncator: String = "...") -> String {
        "\(prefix(maxLength))\(truncator)"
    }
    
    /// 将字符串首字母大写
    /// - Returns: 首字母大写的字符串
    func capitalizeFirst() -> String {
        return "\(prefix(1).capitalized)\(dropFirst)"
    }
}
