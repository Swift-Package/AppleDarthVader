//
//  AlignmentGuideView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

// MARK: - 修改对齐参考线
// 使⽤内置的对⻬参考线对于多个视图我们只能为每个视图都使⽤同样的对⻬
// ⽐如说我们可以将⼀个视图的顶边和另⼀个视图的顶边对⻬或者我们可以将⼀个视图的底部尾⻆和另⼀个视图的底部尾⻆对⻬
// 然⽽我们不能将⼀个视图的中⼼对⻬到另⼀个视图的顶部尾⻆等
// 不过好消息是我们可以覆盖内置 (隐式) 的对⻬参考线甚⾄也可以创建⾃⼰的对⻬⽅式
// SwiftUI 允许我们通过为特定的某个对⻬⽅式提供显式的对⻬参考线来改变视图原先的隐式对⻬参考线
// 例如我们可以覆盖⼀个 Image 的 firstTextBaseline 的计算⽅法：
// let image = Image(systemName: "pencil.circle.fill")
//	.alignmentGuide(.firstTextBaseline, computeValue: { dimension in
//		dimension.height / 2
//	})
// ⚠️提供显式对⻬参考线本身并不会做任何事只有当这个对⻬参考线在实际被使⽤来放置⼦视图时它才会⽣效

#Preview {
	HStack(alignment: .firstTextBaseline) { 
		Image(systemName: "pencil.circle.fill")
			.foregroundStyle(.black)
			.alignmentGuide(.firstTextBaseline, computeValue: { dimension in
				dimension.height / 2
			})
		Text("Pencil")
	}
}

// 然⽽⼀旦我们将 HStack 的对⻬⽅式改为 .center 上⾯⾃定义的对⻬参考线就不再会影响对⻬了
// 传递给 .alignmentGuide API 的 computeValue 闭包拥有⼀个类型为 ViewDimensions 的参数
// 它很类似于 CGSize 拥有 width 和 height 但它同时还允许我们获取底层视图的对⻬参考线
// ⽐如我们也可以按照下⾯的⽅式来编写之前的 image 示例：
#Preview {
	HStack(alignment: .firstTextBaseline) { 
		Image(systemName: "pencil.circle.fill")
			.alignmentGuide(.firstTextBaseline, computeValue: {
				$0[VerticalAlignment.center]
			})
		Text("Pencil")
	}
}

// 在我们想要使⽤两种不同的对⻬参考线来对⻬视图时修改对⻬参考线的⽅式会⾮常有⽤
// 如果我们想要把⼀个⻆标视图的中⼼覆盖到另⼀个视图的顶部尾⻆时可以使⽤下⾯的代码
fileprivate extension View {
	func badge<B: View>(@ViewBuilder _ badge: () -> B) -> some View {
		overlay(alignment: .topTrailing) {
			badge()
				.alignmentGuide(.top) { $0.height / 2 }
				.alignmentGuide(.trailing) { $0.width / 2 }
		}
	}
}

// 它将把 .topTrailing 的对⻬参考线修改到⻆标的视觉中⼼
// 注意 overlay 上指定的对⻬⽅式 (.topTrailing) 和在⻆标上显式设定的对⻬参考线 (.top 和 .trailing) 是相匹配的
