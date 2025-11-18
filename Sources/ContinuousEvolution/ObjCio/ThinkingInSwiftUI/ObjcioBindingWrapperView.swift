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
