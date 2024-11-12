//
//  DataBinary.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/8.
//

import Foundation

public extension Data {
    /// 以二进制形式打印
    func printBinary() {
        withUnsafeBytes { buffer in
            let bytes = buffer.bindMemory(to: UInt8.self)
            for byte in bytes {
                print(String(byte, radix: 2).pad(toSize: 8, using: "0"), terminator: "")
            }
        }
    }
}

private extension String {
    func pad(toSize: Int, using padString: String = " ") -> String {
        let targetSize = toSize - self.count
        if targetSize <= 0 {
            return self
        }
        return String(repeating: padString, count: targetSize) + self
    }
}
