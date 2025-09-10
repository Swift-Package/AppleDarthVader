//
//  NavigationPath.swift
//  SwiftUIPackage
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 3多层级跳转并传递数据

struct NavigationPath: View {
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("一级页面")
                Button {
                    path.append(contentsOf: ["1", "2", "3", "4"])
                } label: {
                    Text("跳转")
                }
            }
            .navigationDestination(for: String.self) { value in
                Text("传递过来数据是 \(value)")
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button {
                                let _ = path.popLast()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("返回")
                                }
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationPath()
}
