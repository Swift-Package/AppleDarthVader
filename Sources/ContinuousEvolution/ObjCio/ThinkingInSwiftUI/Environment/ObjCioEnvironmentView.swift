//
//  ObjCioEnvironmentView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/26.
//

import SwiftUI

fileprivate struct ObjCioEnvironmentView: View {
    var body: some View {
		VStack { 
			Text("Text1")
			Text("Text2")
		}
		// .font(.title)
		.environment(\.font, .title)// 可以达到同样的效果
    }
}

#Preview {
	ObjCioEnvironmentView()
}

fileprivate struct ContentView: View {
	
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize
	@Environment(\.dynamicTypeSize.isAccessibilitySize) private var isAccessibilitySize
	
	var body: some View {
		HStack { 
			Text("Hello")
			if dynamicTypeSize < .large {
				Image(systemName: "hand.wave")
			}
		}
	}
}

#Preview { 
	ContentView()
}

// MARK: - 依赖注入
// .font 修饰器被转换成了⼀个带有 Font? 值的 EnvironmentKeyWritingModifier
// .environment(_:value:) 第⼀个参数是 EnvironmentValues 中的⼀个键路径 (key path)
// 我们可以将环境想象为⼀个带有键和值的字典它从视图树的根部⼀直向下传递到叶⼦节点
// 在视图树的任意位置上我们都可以通过写⼊环境的⽅式来改变某个键的对应值 (就像我们使⽤ .font 修饰器时所做的那样) 之后位于这个环境写⼊修饰器下⽅的⼦树将接受到修改后的环境
// MARK: - 读取系统环境值
// 我们可以使⽤ @Environment 属性包装来从环境中读取⼀个值,这让我们可以访问环境中特定的值也让我们可以观察这个值的变更
// 这意味着在 SwiftUI 中我们不需要考虑像是“⾃动更新到当前区域设置”这种事情因为当区域设置发⽣变化的时候它通过环境进⾏传播
// 所有读取了当前环境的视图都会被重新渲染
// MARK: - 精确键值读取
// 每当动态类型尺⼨变化时 ContentView 都会被重新渲染但是有时我们只对环境值 (也就是本例中的动态类型) 中某⼀个⾮常特定的部分感兴趣
// 环境属性包装 @Environment 恰好⽀持键路径取值正是我们想要的,打个⽐⽅如果我们只对动态类型尺⼨是否是 accessibility 对应的尺⼨感兴趣时
// @Environment(\.dynamicTypeSize.isAccessibilitySize) private var isAccessibilitySize
// 这个属性将只会在 isAccessibilitySize 改变时触发⼀次重新渲染⽽不会在每次 dynamicTypeSize 变更时都重新渲染
// 和 @State 属性类似我们没有任何理由将 @Environment 属性暴露给外界因此我们通常会将环境值标记为私有并使⽤⼀个代码检查规则 (linting rule) 来验证它们的私有访问权限
// 和 State 属性相似的另⼀个点是我们只能在视图的 body 中从环境⾥读取值,因为在视图的初始化⽅法中视图还不具有身份标识,因此我们不能在那⾥对环境进⾏读取
// 如果我们尝试在视图的初始化⽅法中读取环境属性我们会得到⼀个运⾏时的警告
