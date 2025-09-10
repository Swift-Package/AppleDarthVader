//
//  NavigationIsPresented.swift
//  SwiftUIPackage
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 4状态触发跳转

struct NavigationIsPresented: View {
    @State private var isPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    isPresented.toggle()
                } label: {
                    Text("跳转过去")
                }
            }
            .navigationDestination(isPresented: $isPresented) {
                VStack {
                    Text("返回上一级")
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("返回")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationIsPresented()
}
