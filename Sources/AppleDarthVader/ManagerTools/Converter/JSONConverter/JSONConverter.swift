//
//  JSONConverter.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

/// JSON转换工具
@objcMembers
public class JSONConverter: NSObject {
    /// 将JSON转换成字符串
    /// - Parameter json: JSON对象
    /// - Returns: JSON对象的字符串表示
    public static func jsonToString(_ json: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
              let converted = String(data: data, encoding: .utf8)
        else { return nil }

        return converted
    }
}
