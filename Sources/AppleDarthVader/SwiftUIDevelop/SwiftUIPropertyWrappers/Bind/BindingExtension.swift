//
//  BindingExtension.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/9.
//

// https://fatbobman.com/zh/posts/exploring-key-property-wrappers-in-swiftui/

import SwiftUI

public extension Binding {
    // 将一个 Binding<V?> 转换为 Binding<Bool>
    static func isPresented<V>(_ value: Binding<V?>) -> Binding<Bool> {
        Binding<Bool>(
            get: { value.wrappedValue != nil },
            set: {
                if !$0 { value.wrappedValue = nil }
            }
        )
    }
}
