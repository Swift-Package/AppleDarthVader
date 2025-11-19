//
//  ObjcioObservableObjectProtocolView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/10.
//

import SwiftUI

// MARK: - 遵守 ObservableObject 协议并使用 @Published 的计数器模型
fileprivate final class ModelP: ObservableObject {
    @Published var value = 0
}

fileprivate struct CounterP: View {
    
    @StateObject private var model = ModelP()
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview("使用 @StateObject 的情况") {
    CounterP()
}

// MARK: - 不使用 @StateObject 的情况
fileprivate final class Model: ObservableObject {
    
    // MARK: - 不使用 @Published 语法糖
    var value1 = 100 {
        willSet {
            objectWillChange.send()
        }
    }
    // MARK: - 我们只能在使⽤ objectWillChange publisher 的默认实现时才能使⽤这个属性包装
    // 如果我们由于某种原因实现了我们⾃⼰的 publisher 那么 @Published 将会失去作⽤
}

fileprivate struct Counter: View {
    
    private var _model = StateObject(wrappedValue: Model())
    private var model: Model { _model.wrappedValue }
    
    var body: some View {
        Button("Increment\(model.value1)") {
            model.value1 += 1
        }
    }
}

#Preview("不使用 @StateObject 的情况") {
    Counter()
}

// MARK: - 最佳实践(结合 StateObjectWrongUseView 查看)
// @StateObject 和 @State ⼀样也只应该⽤于私有的视图状态
// 我们不应该尝试从外部传⼊对象或在视图的初始化⽅法中创建对象并将其分配给 StateObject 属性
// 这些⽅法⾏不通的原因和我们在讨论 @State 的时候完全相同：
// 在视图的初始化⽅法运⾏的时候视图还不具有身份标识。作为经验法则就像在计数示例中所做的那样
// 如果我们不能在声明属性的同时就为该属性分配初始值那么我们就不应该使⽤ @StateObject
// 在上⾯这个简单的 model 例⼦中, @StateObject 的实现和使⽤了 Observable 的 @State 的实现⼏乎是相同的
// 但是 Observable 的实现是在属性层级上追踪变更⽽ @StateObject 则是在对象层级上进⾏追踪
// 另外 @StateObject 的初始化⽅法接受⼀个 autoclosure,⽽ @State 属性则是在每次视图初始化时计算其初始值
