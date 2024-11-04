//
//  Capitalized.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

@propertyWrapper
public struct Capitalized {
    private var value = ""

    public var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
