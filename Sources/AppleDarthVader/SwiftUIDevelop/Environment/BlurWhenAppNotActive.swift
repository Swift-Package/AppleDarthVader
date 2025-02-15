//
//  BlurWhenAppNotActive.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/1/16.
//

// https://www.youtube.com/watch?v=EWIoQHJq5Tw

import SwiftUI

struct BlurView: ViewModifier {
    @Environment(\.scenePhase) var scenePhase

    func body(content: Content) -> some View {
        content
            .blur(radius: (scenePhase != .active) ? 10 : 0)
            .animation(.default, value: scenePhase)
    }
}

public extension View {
    /// 视图进入后台后模糊化处理
    func blurWhenAppNotActive() -> some View {
        modifier(BlurView())
    }
}
