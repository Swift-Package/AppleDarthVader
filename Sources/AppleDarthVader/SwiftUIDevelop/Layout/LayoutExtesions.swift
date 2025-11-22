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
	
	// MARK: - 橙色高亮视图
	func highlight(enabled: Bool = true) -> some View {
		background {
			if enabled {
				Color.orange
					.padding(-4)
			}
		}
	}
	
	// MARK: - 不是那么完美的角标
	func badgeFixedSize<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
		self.overlay(alignment: .topTrailing) {
			contents()
				.padding(4)
				.background(RoundedRectangle(cornerRadius: 5).fill(.red))
				.fixedSize()
		}
	}
	
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
}

#Preview("角标") { 
	Text("Hello world").badgeFixedSize {
		Text("2026").font(.caption)
	}
}

#Preview("角标") { 
	Text("Hello world").badge {
		Text("2026").font(.caption)
	}
}
