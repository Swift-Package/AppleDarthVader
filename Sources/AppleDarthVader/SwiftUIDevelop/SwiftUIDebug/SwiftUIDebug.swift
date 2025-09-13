//
//  SwiftUIDebug.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/10.
//

import SwiftUI

public extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
    
    // MARK: - 在视图外围展示布局边框
    func debugBorder(color: Color = .red, width: CGFloat = 1, cornerRadius: CGFloat = 0) -> some View {
        self.modifier(DebugBorder(color: color, width: width, cornerRadius: cornerRadius))
    }
}

// MARK: - 调试用显示布局边框
private struct DebugBorder: ViewModifier {
    
    var color: Color = .red
    var width: CGFloat = 1
    var cornerRadius: CGFloat = 0
    
    func body(content: Content) -> some View {
        #if DEBUG
        content
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
        #else
        content
        #endif
    }
}
