//
//  SwiftUIView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/3.
//

import SwiftUI

// MARK: - 视图树的概念
fileprivate struct ViewTree: View {
    var body: some View {
        Text("Hello")
            .padding()
            .background(.blue)
    }
}

#Preview {
    ViewTree()
}
