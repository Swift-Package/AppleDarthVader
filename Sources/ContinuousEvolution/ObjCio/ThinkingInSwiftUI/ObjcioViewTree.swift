//
//  ObjcioViewTree.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/3.
//

import SwiftUI

// MARK: - 视图树的概念
fileprivate struct Hello: View {
    var body: some View {
        Image(systemName: "hand.wave")
        Text("Hello")
    }
}

fileprivate struct Bye: View {
    var body: some View {
        Group {
            Text("And Goodbye")
            Image(systemName: "hand.wave")
        }
    }
}

fileprivate struct Greeting: View {
    
    var body: some View {
        HStack(spacing: 20) {
            Hello()
                .border(.blue)
            Spacer()
            Bye()
                .border(.blue)
        }
    }
}

#Preview {
    Greeting()
}

// MARK: - 视图列表拥有⼀个特殊的性质
// 当像 HStack 这样的容器类视图迭代视图列表时嵌套的列表将会以递归的⽅式进⾏展开
// 这样⼀来⼀棵多元组视图的树最终将被展平为⼀个⼀维的视图列表
// 比如我们给 Hello() 视图添加一个边框将导致每个元素都增加了边框
// 这会为视图列表中的每个元素添加边框，也就是说，图⽚和⽂本都拥会有各⾃的
// 我们经常会在使⽤ Group 时遇到这个⾏为它所抽象的其实是⼀个和布局⽆关的视图构建器
// MARK: - 不过存在特殊情况
// 当把 Group (以及它的修饰器) 当作 ScrollView 的根视图或者唯⼀⼦视图时
// Group 的⾏为就会和 VStack 很像，修饰器也不再会被应⽤到 Group 中每个单独的视图中
// 有另外⼀个例外那就是将 Group 放到 overlay 或者 background ⾥它会表现得像是⼀个 ZStack
