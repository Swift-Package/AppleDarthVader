//
//  OverlayAndBackgroundView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

fileprivate struct OverlayAndBackgroundView: View {
    var body: some View {
		Text("Hello")
			.background(Color.teal)
    }
}

#Preview {
	OverlayAndBackgroundView()
}

// 在布局⽅⾯两者的⼯作⽅式完全相同唯⼀的区别在于 overlay 会把次要视图绘制在主要视图的前⾯⽽ background 则是把次要视图绘制在主要视图的后⽅
// background ⾸先确定它的主要⼦视图 (上例中的 Text) ⼤⼩然后将这个主要⼦视图的尺⼨作为建议尺⼨提供给次要⼦视图
// 背景和覆盖层都不会影响其主要⼦视图的布局因为两者所报告的尺⼨始终都是主要⼦视图的尺⼨
// background 修饰器始终保持为其主要⼦视图的⼤⼩，⽽不依赖于背景中的视图(也就是次要⼦视图)
// 在 overlay 或者 background 中当次要视图是包含有多个视图的⼀列视图时这些视图会被放到⼀个隐式的 ZStack 中

// MARK: - 创建角标
// 我们刚才已经看到 overlay 和 background 具有⼀个特性
// 它们都会把主要⼦视图的尺⼨提供给次要⼦视图,不过有时候可能我们并不希望次要视图的尺⼨依赖于主要视图
// ⽐如创建⼀个⾃定义的 badge 修饰器来在视图的右上⻆绘制⼀个⻆标

fileprivate extension View {
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

#Preview("不是那么完美的角标") { 
	Text("Hello world").badgeFixedSize {
		Text("2026").font(.caption)
	}
}

#Preview("角标") { 
	Text("Hello world").badge {
		Text("2026").font(.caption)
	}
}
