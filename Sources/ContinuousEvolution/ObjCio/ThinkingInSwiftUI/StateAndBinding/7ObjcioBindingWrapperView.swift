//
//  ObjcioBindingWrapperView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/10.
//

import SwiftUI

// MARK: - 使用 @Binding 的计数器
fileprivate struct Counter: View {
    
    @Binding var value: Int
    
    var body: some View {
        Button("Increment\(value)") {
            value += 1
        }
    }
}

#Preview("使用 @Binding 的计数器") {
    @Previewable @State var value = 0
    Counter(value: $value)
}

// MARK: - 不使用 @Binding 的计数器
fileprivate struct RawCounter: View {
	
	var value: Int
	var setValue: (Int) -> Void
	
	var body: some View {
		Button("Increment\(value)") {
			setValue(value + 1)// 按下按钮将 value 加上 1 回调出去
		}
	}
}

fileprivate struct ContentView: View {
	
	@State private var value = 0
	
	var body: some View {
		RawCounter(value: value) { new in
			value = new
		}
	}
}

#Preview("不使用 @Binding 的计数器") { 
	ContentView()
}

// MARK: - 使用 Binding 类型合并 value 和 setValue
fileprivate struct BindingCounter: View {
	
	var value: Binding<Int>
	
	var body: some View {
		Button("Increment\(value.wrappedValue)") { 
			value.wrappedValue += 1
		}
	}
}

#Preview("使用 Binding 类型合并 value 和 setValue") {
	@Previewable @State var value = 0
	BindingCounter(value: $value)
}

// MARK: - 语法糖
fileprivate struct ContentView1: View {
	
	private var _value = State(initialValue: 0)
	private var value: Int {
		get { _value.wrappedValue }
		set { _value.wrappedValue = newValue }
	}
	
	var body: some View {
		Counter(value: _value.projectedValue)
	}
}

#Preview("语法糖") { 
	ContentView1()
}

// 我们可以看到 $value 其实就是 _value.projectedValue 的简写
// 美元符语法并不是 SwiftUI 特有的它是 Swift 属性包装器的⼀个特性
// 美元符就是访问属性包装器的 projectedValue 值的⼀个语法糖
