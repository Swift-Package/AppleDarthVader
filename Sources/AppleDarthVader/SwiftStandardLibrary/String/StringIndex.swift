//
//  StringIndex.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

// Pragma Conference 2024 - So You Think You Know Swift - Nick Lockwood - https://www.youtube.com/watch?v=J5EC8VYhLI8

import Foundation

public extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
