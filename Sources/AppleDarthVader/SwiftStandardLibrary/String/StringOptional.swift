//
//  StringOptional.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.swiftwithvincent.com/tips

import Foundation

public extension String? {
    var orEmpty: String {
        self ?? ""
    }

    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}
