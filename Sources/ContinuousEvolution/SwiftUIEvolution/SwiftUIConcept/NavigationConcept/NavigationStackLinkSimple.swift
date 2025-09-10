//
//  NavigationStackLinkSimple.swift
//  SwiftUIPackage
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 1最简单的无参数跳转

struct NavigationStackLinkSimple: View {
    var body: some View {
        NavigationStack {
            NavigationLink("跳转") {
                Text("简单的页面")
            }
        }
    }
}

#Preview {
    NavigationStackLinkSimple()
}
