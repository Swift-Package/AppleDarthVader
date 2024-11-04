//
//  ArrayOpaqueTypes.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Array where Element == String {
    func transformToInts() -> some Sequence {
        lazy.compactMap { Int($0) }
    }
}
