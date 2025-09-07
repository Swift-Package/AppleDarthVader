//
//  StringIndex.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import Foundation

public extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
