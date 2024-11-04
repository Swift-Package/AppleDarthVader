//
//  StringFormat.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension String {
    // MARK: - Bundle.module必须在包的Target声明resources定义才会生成

    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.module, value: self, comment: self)
    }

    func truncatedPrefix(_ maxLength: Int, using truncator: String = "...") -> String {
        "\(prefix(maxLength))\(truncator)"
    }
}
