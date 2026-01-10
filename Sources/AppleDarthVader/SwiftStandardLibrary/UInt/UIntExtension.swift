//
//  UIntExtension.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/12.
//

import Foundation

public extension UInt {
    // MARK: - 将数值转换成Data数据(比如升级包包数1598包的63E转换成Data表示0x063E)
    func toData() -> Data {
        var remainingValue = self
        var byteArray: [UInt8] = []
        while remainingValue > 0 {
            byteArray.append(UInt8(remainingValue & 0xFF))
            remainingValue >>= 8
        }
        return Data(byteArray.reversed())
    }
}
