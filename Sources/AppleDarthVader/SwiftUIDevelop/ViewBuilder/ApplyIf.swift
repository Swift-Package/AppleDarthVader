//
//  ApplyIf.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/25.
//

// MARK: - 微信公众号 - iOS 新知

import SwiftUI

public extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func applyIfLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}
