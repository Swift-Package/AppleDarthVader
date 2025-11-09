//
//  ObjcioObservedObjectWrapperView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/10.
//

import SwiftUI

fileprivate final class Model: ObservableObject {
    
    @Published var value = 0
    
    nonisolated(unsafe) static let shared = Model()
}

fileprivate struct Counter: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview {
    Counter(model: Model.shared)
}

// MARK: - @ObservedObject 属性包装器的使用场景
// @ObservedObject 属性包装器要⽐ @StateObject 简单得多因为它没有初始值的概念也不需要在多次渲染之间维持被观察对象的存在
// 它所做的事情就只有订阅这个对象的 objectWillChange publisher, 并且在这个 publisher 发出事件时重新渲染视图
// 这些特性决定了当我们 (把 iOS 17 之前的版本作为⽬标平台)想要明确地从外部将对象传递到视图内部时
// @ObservedObject 是唯⼀正确的⼯具,这和⼀个普通属性中的 Observable 对象是等价的
