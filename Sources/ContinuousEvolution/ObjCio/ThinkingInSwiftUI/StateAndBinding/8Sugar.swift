//
//  Sugar.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/19.
//

import SwiftUI

fileprivate final class Model: ObservableObject {
	@Published var value = 0
}

fileprivate struct Counter: View {
	
	@Binding var value: Int
	
	var body: some View {
		Button("Increment\(value)") { value += 1 }
	}
}

fileprivate struct ContentView: View {
	
	@StateObject var model = Model()
	
    var body: some View {
		Counter(value: $model.value)
    }
}

#Preview {
	ContentView()
}

// 美元符语法不仅可以⽤在 @State 属性上，我们也可以在 @StateObject 属性或 @ObservedObject 属性上使⽤它
// 例如可以将值存储在 ContentView 中的⼀个模型对象中
// 我们甚⾄可以创建⼀个计算属性然后为它创建绑定,只要在 $ 后的引⽤具有 getter 和 setter，我们就可以为它创建⼀个绑定
// 例如基于 value 我们可以创建⼀个计算属性将它的值限制在 0 到 10 之间

fileprivate final class Model1: ObservableObject {
	
	@Published var value = 0
	
	var clampedValue: Int {
		get { min(max(0, value), 10) }
		set { value = newValue }
	}
}

fileprivate struct ContentView1: View {
	
	@StateObject var model = Model1()
	
	var body: some View {
		Counter(value: $model.clampedValue)
	}
}

#Preview {
	ContentView1()
}
