//
//  SwiftUIView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/18.
//

// 教程来源 - https://www.youtube.com/watch?v=-1z9aFMQsAE

import SwiftUI

fileprivate struct WindowGroup1: View {
    var body: some View {
        Text("Hello World")
    }
}

#Preview {
    WindowGroup1()
}
// 一个 WindowGroup 本质上是一个用于管理窗口的容器
// 在 macOS 和 iPadOS 系统上应用程序可以显示多个窗口，而在 iOS 系统上则只支持一个窗口
// 要从现有的窗口创建一个新的窗口，您可以定义一个具有 ID 的窗口组然后借助 openWindow 环境呈现一个新的窗口
// 而使用关 dismissWindwo 环境关闭它
//
// Utility Window 实用窗口是一种临时的浮动窗口主要用于展示与其主窗口相关联的数据
// 与 WindowGroup 不同的是实用窗口只能添加一次,此外当处于焦点状态时点击“Esc”按钮即可关闭实用窗口
//
// 菜单栏扩展
// 有许多实用型应用程序并不一定需要窗口来显示内容相反它们使用带有自定义图标置于菜单栏上的菜单栏窗口
// 点击图标时即可打开内容,要实现这一点我们可以使用 MenuBarExtra Scene
//
// 大多数应用程序都提供此选项可通过点击菜单栏下的应用程序名称来访问
// 此选项通常被称为“设置”或“偏好设置”
// 我们可以使用它来自定义或修改应用程序的默认行为访问账户信息、许可信息和其他设置
