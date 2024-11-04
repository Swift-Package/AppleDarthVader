//
//  BundleDecode.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Bundle {
    @nonobjc
    static func decode<T: Codable>(_ type: T.Type, from filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else { fatalError("AppleDarthVader 文件路径不存在 \(filename)") }
        guard let data = try? Data(contentsOf: url) else { fatalError("AppleDarthVader 读取文件失败 \(filename)") }

        do {
            let decodeData = try JSONDecoder().decode(type, from: data)
            return decodeData
        } catch let DecodingError.keyNotFound(key, context) {
            print("AppleDarthVader Key不存在", key, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("AppleDarthVader 类型不匹配", type, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("AppleDarthVader Value不存在", value, context)
        } catch let DecodingError.dataCorrupted(context) {
            print("AppleDarthVader 数据损坏", context)
        } catch {
            fatalError("AppleDarthVader 解码出错")
        }

        fatalError("AppleDarthVader 解码出错")
    }
}
