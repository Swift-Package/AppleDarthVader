//
//  NonEmpty.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/3/17.
//

// WWDC21 - Swift 中的新增功能

import Foundation

@propertyWrapper
public struct NonEmpty<Value: Collection> {
    public init(wrappedValue: Value) {
        precondition(!wrappedValue.isEmpty)
        self.wrappedValue = wrappedValue
    }

    public var wrappedValue: Value {
        willSet { precondition(!wrappedValue.isEmpty) }
    }
}

private struct User {
    @NonEmpty var userName: String
}

func login(@NonEmpty _ userName: String) {}
