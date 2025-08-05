//
//  NavigationViewCustom.swift
//  SwiftUIPackage
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 2自定义跳转按钮并传递数据
struct NavigationViewCustom: View {
    var body: some View {
        NavigationStack {
            VStack  {
                NavigationLink(value: 2) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 50)
                            .foregroundStyle(.red)
                        Text("跳转传递整数值")
                            .foregroundStyle(.white)
                    }
                }
                
                NavigationLink(value: "2") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 50)
                            .foregroundStyle(.red)
                        Text("跳转传递字符串")
                            .foregroundStyle(.white)
                    }
                }
            }
            // MARK: - 多种类型数据传递
            .navigationDestination(for: Int.self) { value in
                Text("传递过来的整数值 \(value)")
            }
            .navigationDestination(for: String.self) { value in
                Text("传递过来的字符串值 \(value)")
            }
        }
    }
}

#Preview {
    NavigationViewCustom()
}
