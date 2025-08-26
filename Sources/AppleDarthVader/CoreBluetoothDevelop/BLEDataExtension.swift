//
//  BLEDataExtension.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/26.
//

import Foundation

public extension UInt8 {
    var intValue: Int {
        return Int(self)
    }
}

public extension UInt16 {
    var intValue: Int {
        return Int(self)
    }
}

public extension UInt32 {
    var intValue: Int {
        return Int(self)
    }
}

public extension Data {
    // MARK: - 获取指定位置的单个字节表示的数值
    func getTargetByte(at offset: Int) -> UInt8 {
        return (getBytes(at: offset)?.first!)!
    }
    
    // MARK: - 获取从指定位置开始的一段字节数据
    func getBytes(at offset: Int, length: Int = 1) -> [UInt8]? {
        // 确保偏移量和长度是有效的
        guard offset >= 0, length > 0, offset + length <= count else {
            print("Invalid offset or length")
            return nil
        }
        
        var bytes: [UInt8] = []
        self.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) in
            let start = pointer.baseAddress?.advanced(by: offset)
            if let start = start {
                let range = start ..< start.advanced(by: length)
                bytes.append(contentsOf: range.map { $0.load(as: UInt8.self) })
            }
        }
        return bytes
    }
    
    // MARK: - 获取指定位置的一段数据
    func slice(from offset: Int, length: Int) -> Data? {
        guard offset >= 0, length > 0, offset + length <= count else { return nil }
        return self.subdata(in: offset ..< offset + length)
    }
    
    // MARK: - 从指定偏移量获取 UInt16（支持大小端）
    func getUInt16(at offset: Int, bigEndian: Bool = false) -> UInt16? {
        guard offset >= 0, offset + 2 <= count else { return nil }
        let subData = self[offset..<offset+2]
        let value = subData.withUnsafeBytes { $0.load(as: UInt16.self) }
        return bigEndian ? value.bigEndian : value.littleEndian
    }
    
    // MARK: - 从指定偏移量获取 UInt32（支持大小端）
    func getUInt32(at offset: Int, bigEndian: Bool = false) -> UInt32? {
        guard offset >= 0, offset + 4 <= count else { return nil }
        let subData = self[offset..<offset+4]
        let value = subData.withUnsafeBytes { $0.load(as: UInt32.self) }
        return bigEndian ? value.bigEndian : value.littleEndian
    }
    
    var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    
    // MARK: - 解码蓝牙地址 (每个字节和 0xAD 进行异或)
    func deobfuscateBtAddress() -> Data {
        return Data(self.map { $0 ^ 0xAD })
    }
    
    // MARK: - 格式化蓝牙地址字符串
    var formatMacAddress: String {
        guard !self.isEmpty else { return "" }
        return self.map { String(format: "%02X", $0) }.joined(separator: ":")
    }
}

public extension String {
    // MARK: - 格式化当前字符串为 MAC 地址样式
    var formatMacAddress: String {
        let clean = self.replacingOccurrences(of: ":", with: "")
                        .replacingOccurrences(of: "-", with: "")
                        .replacingOccurrences(of: " ", with: "")
                        .uppercased()
        
        guard !clean.isEmpty else { return "" }
        
        var result: [String] = []
        var index = clean.startIndex
        while index < clean.endIndex {
            let nextIndex = clean.index(index, offsetBy: 2, limitedBy: clean.endIndex) ?? clean.endIndex
            let byte = String(clean[index..<nextIndex])
            result.append(byte)
            index = nextIndex
        }
        return result.joined(separator: ":")
    }
}
