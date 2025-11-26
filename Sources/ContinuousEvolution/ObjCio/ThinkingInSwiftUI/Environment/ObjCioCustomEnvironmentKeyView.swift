//
//  ObjCioCustomEnvironmentKeyView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/26.
//

import SwiftUI

// MARK: - 自定义角标样式
fileprivate struct Badge: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.caption)
			.foregroundStyle(.white)
			.padding(.horizontal, 6)
			.padding(.vertical, 2)
			.background { 
				Capsule(style: .continuous)
					.fill(.tint)// ⻆标将使⽤当前的 tint 颜⾊进⾏渲染了如果我们没有指定颜⾊就回滚到系统默认的 tint
			}
	}
}

fileprivate struct ObjCioCustomEnvironmentKeyView: View {
    var body: some View {
		Text(3000, format: .number)
			.modifier(Badge())
			.tint(.red)
    }
}

#Preview {
	ObjCioCustomEnvironmentKeyView()
}

// MARK: - 自定义环境 Key
// 我们也可以不依赖 tint 颜⾊，⽽是创建我们⾃⼰的环境键。要实现这种⽅式，需
// 要两个必须步骤和⼀个可选步骤：
// 1.我们必须实现⼀个⾃定义的 EnvironmentKey ⽤来它作为⻆标颜⾊在环境中的键并且将 Color 类型关联到这个键上
// 2.我们必须在 EnvironmentValues 上添加扩展并提供⼀个属性让我们能在环境中获取和设置该值
// 3.(可选)我们可以在 View 上提供⼀个辅助⽅法⽤来轻松地为整棵⼦树设置⻆标颜⾊,这可以让我们将⾃定义的键和扩展隐藏起来同时为⽤户提供⼀个易于发现的 API
//
// 环境键并不是⼀个值⽽是使⽤类型来定义的
// 第一步我们将创建⼀个空的 enum 类型 (或者也可以使⽤ struct 类型)并让它满⾜ EnvironmentKey 协议
fileprivate enum BadgeColorKey: EnvironmentKey {
	static let defaultValue: Color = .blue
}

// EnvironmentKey 协议要求我们实现静态的 defaultValue 属性
// 我们使⽤ Color 作为它的类型编译器将知道这个键所对应的值始终会是 Color 类型
// 我们同时提供了 .blue 作为默认值,除⾮我们在视图树上游的某个地⽅在环境中为这个键设置了明确的值否则当我们从环境中读取⻆标颜⾊时都会取到这个默认值
// 第⼆步我们需要向 EnvironmentValues 结构体添加⼀个计算属性
// 我们在环境中进⾏读写时需要⼀个键路径,这里我们使⽤ badgeColor 这个名字
fileprivate extension EnvironmentValues {
	var badgeColor: Color {
		get { self[BadgeColorKey.self] }
		set { self[BadgeColorKey.self] = newValue }
	}
}

fileprivate extension View {
	func badgeColor(_ color: Color) -> some View {
		environment(\.badgeColor, color)
	}
}

// 想要读取⻆标颜⾊我们可以在 Badge 视图修饰器⾥使⽤ @Environment 属性包装器
fileprivate struct BadgeE: ViewModifier {
	
	@Environment(\.badgeColor) private var badgeColor
	
	func body(content: Content) -> some View {
		content
			.font(.caption)
			.foregroundStyle(.white)
			.padding(.horizontal, 6)
			.padding(.vertical, 2)
			.background { 
				Capsule(style: .continuous)
					.fill(badgeColor)// 获取环境中的角标颜色
			}
	}
}

#Preview { 
	VStack {
		Text(3000, format: .number)
			.modifier(BadgeE())
		Text("Test")
			.modifier(BadgeE())
	}
	.badgeColor(.yellow)
}
