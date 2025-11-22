//
//  ZZStackView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

fileprivate struct ZZStackView: View {
	var body: some View {
		ZStack {
			Color.teal
			Text("Hello, world")
		}
	}
}

#Preview {
	ZZStackView()
}

// overlay 和 background 使⽤主要⼦视图的尺⼨并把次要⼦视图的尺⼨丢弃掉
// 当使⽤ ZStack 时它的所有⼦视图的 frame 将组合起来进⾏并集 (union) 操作并依此计算 ZStack ⾃身的尺⼨
// 当我们把这个视图作为⼀个新的 iOS app 的根视图时颜⾊部分会拉伸到整个安全区域的完整尺⼨(⚠️现在颜色不会拉伸到整个安全区域的完整尺寸了)
// 这是因为 ZStack 接受到的建议尺⼨是整个安全区域然后它会将同样的值再提供给它的每个⼦视图

fileprivate extension View {
	// MARK: - 把⼀个⻆标视图的中⼼覆盖到另⼀个视图的顶部尾⻆
	func badge<Badge: View>(@ViewBuilder _ badge: () -> Badge) -> some View {
		overlay(alignment: .topTrailing) {
			badge()
				.alignmentGuide(.top) { $0.height / 2 }
				.alignmentGuide(.trailing) { $0.width / 2 }
				.padding(4)
				.background(.red)
				.clipShape(.capsule)
		}
	}
	
	// MARK: - 把⼀个⻆标视图的中⼼覆盖到另⼀个视图的顶部尾⻆(⚠️使用 ZStack 实现的会有问题)
	func badge1<Badge: View>(@ViewBuilder _ badge: () -> Badge) -> some View {
		ZStack(alignment: .topTrailing) {
			self
			badge()
				.alignmentGuide(.top) { $0.height / 2 }
				.alignmentGuide(.trailing) { $0.width / 2 }
				.padding(4)
				.background(.red)
				.clipShape(.capsule)
		}
	}
}

#Preview { 
	HStack(alignment: .top) { 
		Text("Hello world").badge {
			Text("2026").font(.caption)
		}
		
		ZStack { 
			Text("Hello world")
				.badge1 { 
					Text("2026").font(.caption)
				}
		}
	}
	.debugBorder()
}

// 如果我们不使⽤ overlay ⽽是⽤ ZStack 来实现 overlay 和 background 那⼀节中有关⻆标的例⼦那这个⻆标将会影响到它所附加的视图的布局
// 因为此时 ZStack 的尺⼨将会包括这个⻆标,虽然使⽤了⻆标的单个视图看上去外观是⼀样的但是与其他视图之间的布局⾏为却已经发⽣了改变
// 上⾯的两个视图都设定为了在 HStack 中进⾏顶部对⻬,两者也都拥有顶边和尾端对⻬的⻆标
// 左侧的视图使⽤了 overlay 来实现⻆标所以它在 HStack 中的布局并不会受到⻆标视图的影响
// 右侧的视图在实现⻆标时使⽤的是 ZStack 因此这个视图的顶边变成了⻆标的顶边

// MARK: - 支持工具函数
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
