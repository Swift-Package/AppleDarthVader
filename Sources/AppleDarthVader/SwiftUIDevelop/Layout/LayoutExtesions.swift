//
//  LayoutExtesions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/20.
//

// 摘抄 - SwiftUI 编程思想 - 布局

import SwiftUI

public extension View {
	
	// MARK: - 令视图占据整个可⽤宽度
	func proposedWidthOrGreater() -> some View {
		frame(maxWidth: .infinity)
	}
	
	// MARK: - 确保框架⽆视它的⼦视图的尺⼨,框架报告的宽度将总是它接受到的建议宽度
	func acceptProposedWidth() -> some View {
		frame(minWidth: 0, maxWidth: .infinity)
	}
	
	func highlight(enabled: Bool = true) -> some View {
		background {
			if enabled {
				Color.orange
					.padding(-3)
			}
		}
	}
	
	func badge<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
		self.overlay(alignment: .topTrailing) {
			contents()
				.padding(3)
				.background {
					RoundedRectangle(cornerRadius: 5).fill(.teal)
				}
		}
	}
	
	func badgeFixedSize<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
		self.overlay(alignment: .topTrailing) {
			contents()
				.padding(3)
				.background(RoundedRectangle(cornerRadius: 5))
				.fixedSize()
		}
	}
	
	// MARK: - 把⼀个⻆标视图的中⼼覆盖到另⼀个视图的顶部尾⻆
	func badge<Badge: View>(@ViewBuilder _ badge: () -> Badge) -> some View {
		overlay(alignment: .topTrailing) {
			badge()
				.alignmentGuide(.top) { $0.height / 2 }
				.alignmentGuide(.trailing) { $0.width / 2 }
		}
	}
}

#Preview { 
	Text("Hello, World!")
		.frame(minWidth: 0, maxWidth: .infinity)
		.background(Color.teal)
		.padding(10)
}

// MARK: - 让我们来看看当上⾯的视图渲染到 320⨉480 的屏幕上时会发⽣什么
// 1. 系统向 padding 提出 320⨉480 作为建议尺⼨
// 2. padding 向 background 建议 300⨉460
// 3. background 将同样的 300⨉460 建议给它的主要⼦视图也就是 frame
// 4. frame 把同样的 300⨉460 提供给它的⼦视图 Text
// 5. Text 汇报它的尺⼨为 76⨉17
// 6. frame 的宽度变为 max(0, min(.infinity, 300)) = 300。注意这⾥的 0 和 .infinity 值都是灵活尺⼨的参数⾥指定的值
// 7. background 把灵活框架的尺⼨ (300⨉17) 提供给次要⼦视图 (Color)
// 8. 颜⾊视图接受这个建议，并将它作为⾃⼰的尺⼨汇报
// 9. background 将它的主要⼦视图的尺⼨ (300⨉17) 进⾏汇报
// 10. padding 在每条边上加上 10，最终它的尺⼨为 320⨉37
// 灵活框架是 SwiftUI 中唯⼀可以明确指定理想尺⼨的 API
// 所谓理想尺⼨就是如果某个维度上收到的建议尺⼨为 nil 时将采⽤的尺⼨
// 如果指定了 idealWidth 或 idealHeight 参数，在灵活框架收到包含 nil 的建议尺⼨时 (通常来源于 fixedSize 修饰器)
// 它会把指定的理想尺⼨提供给⼦视图并且这个尺⼨也会被作为框架⾃身的尺⼨进⾏报告⽽再不考虑其⼦视图的尺⼨
