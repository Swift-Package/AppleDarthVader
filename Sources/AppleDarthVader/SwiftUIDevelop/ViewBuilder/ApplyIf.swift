//
//  ApplyIf.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/25.
//

// MARK: - 微信公众号 - iOS 新知
// MARK: - ⚠️这个修饰符扩展在 王巍《SwiftUI 编程思想》中被标记为不建议使用的反面模式

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

fileprivate struct ApplyIfView: View {
    
    @State var x = true
    
    var body: some View {
        Text("Hello")
            .applyIf(x) { t in
                t.background(.yellow)
            }
        Button {
            x.toggle()
        } label: {
            Text("Change")
        }

    }
}

#Preview {
    
    @Previewable @State var x = true
    
    ApplyIfView(x: x)
}
