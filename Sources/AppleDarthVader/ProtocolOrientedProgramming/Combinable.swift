//
//  Combinable.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

protocol Combinable {
    func combine(_ other: Self) -> Self
}

extension String: Combinable {
    func combine(_ other: String) -> String {
        self + other
    }
}

extension Array: Combinable {
    func combine(_ other: [Element]) -> [Element] {
        self + other
    }
}
