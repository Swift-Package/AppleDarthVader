//
//  CollectionSafe.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// 将集合中的nil移除[1, 2, nil, 3, nil, 4].nilValuesRemoved -> [1, 2, 3, 4]
    /// - Returns: 将集合中的nil移除后的新集合
    func nilValuesRemoved<Wrapped>() -> [Wrapped] where Element == Wrapped? {
        compactMap { $0 }
    }
}
