//
//  ObjcioBehindObservableMacro.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/9.
//

import SwiftUI

// MARK: - 不使用 Observable 宏的计数器
fileprivate final class NoObservableClass: ObservableObject {
    @Published var value = 0
}

fileprivate struct NoObservableCounter: View {
    
    @StateObject private var model = NoObservableClass() // 需要使用 @StateObject 而不是 @State
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview("不使用 Observable 宏的计数器") {
    NoObservableCounter()
}

// MARK: - 使用 Observable 宏的计数器
@Observable
fileprivate final class ObservableClass {
    var value = 0
}

fileprivate struct ObservableCounter: View {
    
    @State private var model = ObservableClass() // 使用简单的 @State
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview("使用 Observable 宏的计数器") {
    ObservableCounter()
}

// MARK: - 不使用 @State 包装器的示例
@Observable
fileprivate final class Model {
    
    nonisolated(unsafe) static let shared = Model()
    
    var value = 0
}

fileprivate struct Counter: View {
    
    var model: Model
    
    var body: some View {
        Button("Increment\(model.value)") {
            model.value += 1
        }
    }
}

#Preview("不使用 @State 包装器") {
    Counter(model: Model.shared)
}

// MARK: - Observable 宏
// 1.它会为所附加的类型添加遵守 Observable 标记协议的声明,这是⼀个在运⾏时没有实际作⽤在编译时标记⼀个类的空协议
// 2.它修改对象的属性以追踪读取和写⼊访问
// 不管对象存储在哪⾥也不需要任何特殊的属性包装器只需访问 Observable 对象的属性对它的观察就⾃动建⽴了
// 因此我们只需要使⽤ @State 属性包装器并与 Observable 对象结合起来就可以更改对象的⽣命周期管理⽅式了
// MARK: - Observable 存在两种使⽤⽅式
// 1.使⽤ @State 属性包装器来声明属性
// 将 Observable 对象的⽣命周期与视图的渲染节点的⽣命周期关联起来 (换句话说它是视图私有的对象)
// 2.将它存储在普通属性中
// 想要使⽤具有独⽴于视图的渲染节点的⽣命周期的对象 (换句话说我们从外部传递的对象)
// MARK: - 依赖建立
// 新的基于宏的对象观察模型不仅引⼊了更⽅便的语法还改变了视图和 Observable 对象之间的依赖关系的形成⽅式
// 在使⽤旧的属性包装器时 SwiftUI 会⽆脑订阅视图中所有被声明为 @StateObject 或 @ObservedObject 的属性中的 objectWillChange publisher
// ⽽使⽤新的 Observable 宏时不论 Observable 对象来⾃何处只要在视图 body 中访问到的它的属性这个属性就会成为视图的依赖
// 这套新模型⽐起之前要简单得多,例如在视图 body 中访问⼀个 (可观察的) 全局单例将会⾃动形成访问属性与视图之间的依赖关系⽽⽆需我们使⽤ @ObservedObject 将此单例传递给视图
// 同样 Observable 对象可以嵌套在可选值、数组或其他集合中,由于这是在视图 body 中在属性层级上进⾏的追踪和依赖所以观察和视图更新等都将会按照预期⼯作
// MARK: - 性能提升
// 如果你在视图 body 中仅使⽤了对象的某⼀个属性那么对其他属性的更改并不会导致该视图重新绘制
// 同样如果你没有使⽤模型对象例如当它仅在代码的⼀个分⽀中存在时则根本不会观察这个对象
// 这可以减少很多不必要的视图更新从⽽提⾼性能
// MARK: - 常见的错误使用方式
// 1.使⽤ @State 来处理从外部传⼊的对象❌
// 2.不使⽤ @State 来处理视图内部私有的对象❌
// 换句话说前⼀个问题是在对象的⽣命周期已经由视图外部进⾏管理时依然使⽤了 @State
// ⽽后⼀个问题是在对象的⽣命周期没有在视图外部进⾏任何管理时却仍然不使⽤ @State
