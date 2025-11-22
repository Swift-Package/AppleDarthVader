//
//  AspectRatioView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

// MARK: - SwiftUI 编程思想关于布局宽高比
fileprivate struct AspectRatioView: View {
    var body: some View {
		Rectangle()
			.fill(.clear)
			.frame(width: 250, height: 250)
			.debugBorder(color: .gray)
			.background { 
				Rectangle()
					.fill(.clear)
					.frame(width: 200, height: 200)
					.debugBorder(color: .green)
					.background {
						Color.cyan
							.aspectRatio(4 / 3, contentMode: .fit)
							.debugBorder()
					}
			}
    }
}

#Preview {
	AspectRatioView()
}

// MARK: - aspectRatio fit 模式
// 这个 aspectRatio 修饰器将会计算出⼀个能够适配进建议尺⼨的宽⾼⽐为 4/3 的矩形然后将它作为建议尺⼨提供给⼦视图
// 对于⽗视图它总是把⼦视图的尺⼨汇报上去⽽不去理会建议尺⼨或者设定的⽐例
// 我们来假设⼀个 200x200 的建议尺⼨然后 aspectRatio 通过计算得到在这个建议尺⼨下满⾜ 4/3 宽⾼⽐的最⼤矩形是 200⨉150
// 它把这个尺⼨建议给 Color,后者会直接接受建议,最后 aspectRatio 把 200⨉150 作为它⾃⼰的尺⼨进⾏汇报

#Preview("aspectRatio fill") {
	Rectangle()
		.fill(.clear)
		.frame(width: 250, height: 250)
		.debugBorder(color: .gray)
		.background { 
			Rectangle()
				.fill(.clear)
				.frame(width: 200, height: 200)
				.debugBorder(color: .green)
				.background {
					Color.cyan
						.aspectRatio(4 / 3, contentMode: .fill)
						.debugBorder()
				}
		}
}

// MARK: - aspectRatio fill 模式
// 我们还是从 200x200 的建议尺⼨开始 .aspectRatio 将会计算⼀个 4/3 宽⾼⽐能够覆盖住整个建议尺⼨的最⼩矩形
// 本例中这个矩形的尺⼨约为 266.6⨉200 它把这个尺⼨建议给 Color,后者会直接接受建议
// 最后 aspectRatio 把 266.6⨉200 这个⼦视图的尺⼨作为它⾃⼰的尺⼨进⾏汇报

// MARK: - aspectRatio 图片
#Preview("aspectRatio 图片") {
	Image("header")
		.resizable()
		.aspectRatio(contentMode: .fit)
}

// 请注意 .resizable 修饰器是对 Image 进⾏修改并不会为视图树添加额外的层级
// .scaleToFit 和 .scaleToFill 修饰器分别是 .aspectRatio(contentMode: .fit) 和 .aspectRatio(contentMode: .fill) 的简写形式
// 因为我们没有指定具体的宽⾼⽐ .aspectRatio 将会 (通过提供 nil⨉nil 尺⼨) 探测⼦视图的理想尺⼨并依据这个尺⼨计算宽⾼⽐
// 假设建议尺⼨为 200⨉200 且图像的理想尺⼨为 100⨉30 这个例⼦的布局步骤如下
// 1. 200⨉200 的建议尺⼨被提供给 aspectRatio
// 2. aspectRatio 向图像建议 nil⨉nil
// 3. 图像报告⾃⼰的理想尺⼨ 100⨉30
// 4. aspectRatio 将⼀个宽⾼⽐为 100/30 的矩形适配到 200⨉200 中得到 200⨉60 并将这个尺⼨提供给图⽚
// 5. 图⽚将⾃⼰的尺⼨报告为 200⨉60
// 6. aspectRatio 将⼦视图的尺⼨ 200⨉60 作为⾃⼰的尺⼨进⾏报告
// ⚠️要注意 aspectRatio 视图最终不⼀定会具有我们指定的宽⾼⽐
// 虽然修饰器会向其⼦视图提议⼀个具有指定宽⾼⽐的尺⼨但和其他情况⼀样⼦视图才是根据建议决定⾃⼰尺⼨的⻆⾊
// 如果⼦视图⽆法灵活地将⾃身适应到指定的宽⾼⽐那么 aspectRatio 修饰器⾃身也不会满⾜这个宽⾼⽐因为它的尺⼨取决于其⼦视图的尺⼨

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
