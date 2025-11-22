//
//  AlignmentIDCustom.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/22.
//

import SwiftUI

// MARK: - ⾃定义对⻬标识
// 到⽬前为⽌我们使⽤了内置的隐式对⻬⽅式并学习了如何使⽤ .alignmentGuide API 来为内置的对⻬⽅式指定显式的对⻬参考线
// 其实我们还可以更进⼀步去设置完全⾃定义的对⻬⽅式
// 让我们来考虑这样⼀个布局
// 最下⽅稍⼤⼀点的菜单按钮需要和上⾯⼏个单独的带⽂字的菜单按钮的圆形部分在竖直⽅向上居中对⻬

#Preview { 
	VStack(alignment: .trailing) { 
		HStack { 
			Text("Inbox")
			Image(systemName: "tray.and.arrow.down")
				.frame(width: 30, height: 30)
				.background(.gray.opacity(0.5))
				.clipShape(.circle)
		}
		
		HStack { 
			Text("Send")
			Image(systemName: "tray.and.arrow.up")
				.frame(width: 30, height: 30)
				.background(.gray.opacity(0.5))
				.clipShape(.circle)
		}
		
		Image(systemName: "line.3.horizontal")
			.frame(width: 40, height: 40)
			.background(.gray.opacity(0.5))
			.clipShape(.circle)
	}
}

// 这⾥的问题是 VStack 的⽔平对⻬⽅式：内置的对⻬⽅式都⽆法符合我们的需求
// 我们可以尝试在 VStack 上指定 .trailing 对⻬然后在两个⼩菜单的 CircleButton 上为 .trailing 指定显式的对⻬参考线
// 但是这也⾏不通：当 VStack 放置它的⼦视图时，它确实会向每个⼦视图询问 .trailing 对⻬参考线
// 但因为 HStack 也有它⾃⼰的 .trailing 对⻬参考线所以在 CircleButton 上定义的显式对⻬参考线将永远不会被使⽤
// 这时候就要⽤到⾃定义对⻬了它能够跨越容器视图使⽤
// 实现⾃定义对⻬的第⼀步是创建⼀个遵守 AlignmentID 协议的类型

struct MenuAlignment: AlignmentID {
	static func defaultValue(in context: ViewDimensions) -> CGFloat {
		context.width / 2
	}
}

// 我们需要为特定的对⻬选择⼀个默认值,之后除⾮我们指定⼀个显式的值否则都将使⽤这个默认值来进⾏对⻬
// 对于我们想要达成的⽬的可以选择将视图的⽔平中⼼⽤作默认值
// 现在我们可以在 HorizontalAlignment 结构体中为我们的⾃定义对⻬添加⼀个静态常量就像 SwiftUI 在定义内置对⻬⽅式时做的⼀样
// 现在 .menu 的对⻬⽅式将由我们的 MenuAlignment 结构体进⾏标识
// 可以将它⽤在菜单的 VStack ⾥并为 CircleButton 的 .menu 对⻬⽅式指定显式的对⻬参考线
extension HorizontalAlignment {
	static let menu = HorizontalAlignment(MenuAlignment.self)
}

#Preview { 
	VStack(alignment: .menu) { 
		HStack { 
			Text("Inbox")
			Image(systemName: "tray.and.arrow.down")
				.frame(width: 30, height: 30)
				.background(.gray.opacity(0.5))
				.clipShape(.circle)
				.alignmentGuide(.menu) { $0.width / 2 }
		}
		
		HStack { 
			Text("Send")
			Image(systemName: "tray.and.arrow.up")
				.frame(width: 30, height: 30)
				.background(.gray.opacity(0.5))
				.clipShape(.circle)
				.alignmentGuide(.menu) { $0.width / 2 }
		}
		
		Image(systemName: "line.3.horizontal")
			.frame(width: 40, height: 40)
			.background(.gray.opacity(0.5))
			.clipShape(.circle)
	}
}

// 我们没有为⼤的菜单按钮本身指定 .menu 的显式值，因为 .menu 的默认值已经是中⼼对⻬了这和我们的⽬标是相同的
// 现在当 VStack 向它的⼦视图询问 .menu 对⻬参考线时 HStack 将会先去咨询它的⼦视图看看它们是否能提供⼀个显式的对⻬参考线
// 如果⼦视图中没有明确定义再回滚到默认值
// 这意味着现在当被问到 .menu 对⻬参考线时 HStack 会返回我们定义在 CircleButton 上的显式对⻬参考线
// 也就是说就算我们在这些显式对⻬参考线上使⽤的是默认值,现在这些显式的对⻬参考线也会被优先使⽤来取代 HStack 上的隐式对⻬参考线
