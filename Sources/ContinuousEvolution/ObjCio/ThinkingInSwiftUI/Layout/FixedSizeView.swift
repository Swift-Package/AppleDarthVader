//
//  FixedSizeView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

fileprivate extension View {
	// MARK: - 在视图外围展示布局边框
	func debugBorder(color: Color = .red, width: CGFloat = 1, cornerRadius: CGFloat = 0) -> some View {
		self.modifier(DebugBorder(color: color, width: width, cornerRadius: cornerRadius))
	}
}

// MARK: - 调试用显示布局边框
fileprivate struct DebugBorder: ViewModifier {
	
	var color: Color = .red
	var width: CGFloat = 1
	var cornerRadius: CGFloat = 0
	
	func body(content: Content) -> some View {
		content
			.overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
	}
}


#Preview { 
	Text("Hello, World!")
		.frame(minWidth: 0, maxWidth: .infinity)
		.background(Color.teal)
		.padding(10)
		.debugBorder()
}

// MARK: - 让我们来看看当上⾯的视图渲染到 320⨉480 的屏幕上时会发⽣什么
// 1. 系统向 padding 提出 320⨉480 作为建议尺⼨
// 2. padding 上下左右去掉 10 后向 background 建议 300⨉460
// 3. background 将同样的 300⨉460 建议给它的主要⼦视图也就是 frame
// 4. frame 把同样的 300⨉460 提供给它的⼦视图 Text 因为宽度符合区间内
// 5. Text 汇报它的尺⼨为 76⨉17
// 6. frame 的宽度变为 max(0, min(.infinity, 300)) = 300 注意这⾥的 0 和 .infinity 值都是灵活尺⼨的参数⾥指定的值
// 7. background 把灵活框架的尺⼨ (300⨉17) 提供给次要⼦视图 (Color)
// 8. 颜⾊视图接受这个建议并将它作为⾃⼰的尺⼨汇报
// 9. background 将它的主要⼦视图的尺⼨ (300⨉17) 进⾏汇报
// 10.padding 在每条边上加上 10，最终它的尺⼨为 320⨉37
// MARK: - 理想尺寸
// 灵活框架是 SwiftUI 中唯⼀可以明确指定理想尺⼨的 API
// 所谓理想尺⼨就是如果某个维度上收到的建议尺⼨为 nil 时将采⽤的尺⼨
// 如果指定了 idealWidth 或 idealHeight 参数，在灵活框架收到包含 nil 的建议尺⼨时 (通常来源于 fixedSize 修饰器)
// 它会把指定的理想尺⼨提供给⼦视图并且这个尺⼨也会被作为框架⾃身的尺⼨进⾏报告⽽再不考虑其⼦视图的尺⼨

fileprivate struct FixedSizeView: View {
    var body: some View {
		VStack { 
			Text("This is a longer text")
				.frame(width: 50, height: 50)
			
			Text("This is a longer text")
				.fixedSize()
				.frame(width: 50, height: 50)
		}
		
    }
}

#Preview {
	FixedSizeView()
}

// Text 会尝试各种办法来确保把⾃⼰渲染在建议尺⼨之中 (⽐如截断或者换⾏)
// 想要规避这种⾏为可以向 Text 提供 nil⨉nil 的建议尺⼨这样⽂本就会变为理想尺⼨,根据视图树的不同这么做可能导致⽂本的绘制超出边界
// ⽂本绘制在了 frame 修饰器 (它⽤来向 Text 提供⼀个确定的建议尺⼨) 的边界范围之外
// 这是因为在默认情况下 SwiftUI 的视图是不会被裁剪的,如果我们需要进⾏裁剪可以使⽤ clipped 修饰器来启⽤
