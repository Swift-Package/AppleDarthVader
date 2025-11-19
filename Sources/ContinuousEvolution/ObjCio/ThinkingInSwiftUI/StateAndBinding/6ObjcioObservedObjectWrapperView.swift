//
//  ObjcioObservedObjectWrapperView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/10.
//

import SwiftUI

// MARK: - @ObservedObject 属性包装器的使用场景
// @ObservedObject 属性包装器要⽐ @StateObject 简单得多因为它没有初始值的概念也不需要在多次渲染之间维持被观察对象的存在
// 它所做的事情就只有订阅这个对象的 objectWillChange publisher 并且在这个 publisher 发出事件时重新渲染视图
// 这些特性决定了当我们 (把 iOS 17 之前的版本作为⽬标平台)想要明确地从外部将对象传递到视图内部时
// @ObservedObject 是唯⼀正确的⼯具,这和⼀个普通属性中的 Observable 对象是等价的
fileprivate final class Model: ObservableObject {
    
    nonisolated(unsafe) static let shared = Model()
    
    @Published var value = 0
}

fileprivate struct Counter: View {
    
    @ObservedObject var model: Model
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview("使用 @ObservedObject 接收外部传递的对象") {
    Counter(model: Model.shared)
}

// MARK: - 计数器视图 CounterX 使用的数据模型
fileprivate final class CounterModel: ObservableObject {
    @Published var value = 0
}

// MARK: - 计数器视图
fileprivate struct CounterX: View {
    
    @ObservedObject var model: CounterModel// ⚠️计数器视图观察的对象
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

// MARK: - ModelX 用来管理不同的计数器模型
fileprivate final class ModelX {
    
    nonisolated(unsafe) static let shared = ModelX()
    
    var counters: [String: CounterModel] = [:]
    
    // MARK: - 根据不同房间获取不同的计数器模型
    func counterModel(for room: String) -> CounterModel {
        if let model = counters[room] {
            return model
        }
        let model = CounterModel()
        counters[room] = model
        return model
    }
}

fileprivate struct ContentView: View {
    
    @State private var selectedRoom = "Hallway"
    
    var body: some View {
        VStack {
            Picker("Room", selection: $selectedRoom) {
                ForEach(["Hallway", "Living Room", "Kitchen"], id: \.self) { value in
                    Text(value)
                        .tag(value)
                }
            }
            .pickerStyle(.segmented)
            
            CounterX(model: ModelX.shared.counterModel(for: selectedRoom))
        }
    }
}

#Preview("监听不同的对象") {
    ContentView()
}

// 我们可以使⽤ Picker 来切换房间,从共享的 model 中取得正确的 CounterModel 然后将它传递到计数器视图中
// 共享 model 负责管理不同的 CounterModel 实例并在视图更新时保持它们的存在
// @ObservedObject 的唯⼀任务是订阅当前实例 (并取消对先前实例的订阅) 以便在更改发⽣时收到通知
// 请注意当我们切换房间时计数器视图在渲染树中的节点不会被重新创建它只是观察了⼀个不同的对象
// 让我们想象⼀下⽬前计数器正在观察 “Living Room” (客厅) 对象
// 当 Counter 被渲染时视图树和渲染树都包含指向该对象的指针
// 要注意只有渲染树才负责观察对象视图树依然只扮演蓝图的⻆⾊
// 当⽤户选择 “Kitchen” (厨房) 时计数器视图的 ObservedObject 现在指向了另⼀个 model 对象因此渲染树也许要相应地进⾏更新
// ⾸先渲染树将它所观察的 model 引⽤从 “Living Room” 更改为现在的 “Kitchen”
// 最后计数器视图的 body 被重新执⾏并构建出⼀棵新的视图树渲染树也随之更新
// 有意思的是当 SwiftUI 刚推出时并不存在 @StateObject 这个属性包装器,我们只能使⽤ @ObservedObject
// 尽管我们仍然能⽤它编写出相同的程序但是通过引⼊ @StateObject 我们可以⽤更少的代码替代掉部分 @ObservedObject 的使⽤场景
