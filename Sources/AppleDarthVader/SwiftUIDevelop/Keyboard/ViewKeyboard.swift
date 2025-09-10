//
//  ViewKeyboard.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/21.
//

import SwiftUI

public extension View {
    // MARK: - 收起屏幕键盘

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ViewKeyboardTestsView: View {
    @State private var text = ""

    var body: some View {
        ZStack {
            TextField("请输入文本", text: $text)
                .padding()
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    ViewKeyboardTestsView()
}
