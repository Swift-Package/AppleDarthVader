//
//  ColorSchemeView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

import SwiftUI

fileprivate struct ColorSchemeView: View {
	
	@Environment(\.colorScheme) var colorScheme
	@State private var showSheet = false
	
    var body: some View {
		VStack {
			Button(action: {
				
			}) {
				Image(systemName: "xmark.circle.fill")
			}
			.foregroundColor(colorScheme == .dark ? .red : .black)
			
			VStack {
				Text("Text 1")
					.preferredColorScheme(.light)
				Text("Text 2")
			}
			.preferredColorScheme(.dark)
			
			Button("Show sheet") {
				showSheet = true
			}
			.sheet(isPresented: $showSheet) {// 但是 sheet 不会被影响
				Text("Sheet content")
					.preferredColorScheme(.light)
			}
			
			VStack {
				Text("Text 1")
				MyCustomView()
					.background(.purple)
					.environment(\.colorScheme, .light)// ⚠️指定视图的颜色方案的方法
			}
		}
    }
}

fileprivate struct MyCustomView: View {
	var body: some View {
		Text("Text 2")
			.padding()
	}
}

#Preview {
	ColorSchemeView()
		.preferredColorScheme(.dark)// 最高优先级
}
