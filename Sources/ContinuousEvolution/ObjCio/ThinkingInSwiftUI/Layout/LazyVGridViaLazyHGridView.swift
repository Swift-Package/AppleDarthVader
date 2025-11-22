//
//  LazyVGridViaLazyHGridView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

// 附加博客 - https://www.objc.io/blog/2020/11/23/grid-layout
// MARK: - 下面是 SwfitUI 编程思想中的解释
// ⽹格⽀持三种列的类型
// 1.固定列 - ⽆条件地使⽤指定的宽度
// 2.灵活列(flexible column) - 在它们的宽度上界和下界之间灵活可变
// 3.⾃适应列(adaptive column) - 实际上是包含了多个⼦列的容器

import SwiftUI

#Preview {
	let columns = [
		GridItem(.flexible(), spacing: 16),// spacing 参数是列之间的间距
		GridItem(.flexible(), spacing: 6),
		GridItem(.flexible())
	]
	
	LazyVGrid(columns: columns, spacing: 0) {// spacing 参数是行之间的间距
		ForEach(0..<15) { i in
			Text("\(i)")
				.frame(maxWidth: .infinity, minHeight: 50)
				.background(Color.blue.opacity(0.3))
				.cornerRadius(8)
		}
	}
}

#Preview {
	let columns = [
		GridItem(.flexible(minimum: 20, maximum: 50), spacing: 32),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	ScrollView {
		LazyVGrid(columns: columns, spacing: 32) {
			ForEach(0..<50) { i in
				RoundedRectangle(cornerRadius: 10)
					.fill(.clear)
					.background(Color.blue.opacity(0.3))
					.frame(height: 100)
			}
		}
		.padding()
	}
}

// MARK: - 计算过程
// LazyVGrid 布局的第⼀步是根据⽹格收到的建议尺⼨的宽度来决定⽹格中列的宽度
// ⽹格⾸先从建议宽度中减去所有固定列的宽度。对于剩余的列算法将把剩余宽度除以剩余的列数，然后按照顺序建议给每⼀列
// 灵活列将会使⽤它的 (最⼩和/或最⼤宽度) 来限制这个建议宽度
// ⾃适应列⽐较特殊：⽹格会通过将建议的列宽度除以为这个⾃适应列指定的最⼩宽度从⽽尽可能多地容纳⾃适应列中的⼦列
// 之后这些⼦列会被拉伸到指定的最⼤宽度以填充剩余空间
// 现在列的宽度已经都被计算出来了，⽹格会把所有列的宽度加起来，再算上列之间的间距把结果作为它⾃⼰的宽度
// 对于⾼度，⽹格会向它的⼦视图建议 columnWidth ⨉ nil 的尺⼨来计算⾏的⾼度,然后把所有的⾏⾼和⾏间距加起来作为⾃⼰的⾼度
// 和 HStack 及 VStack 相反的是⽹格会执⾏两次列布局算法：
// 第⼀次在布局阶段中，⽽之后在渲染阶段⼜执⾏⼀次。在布局阶段⽹格使⽤它收到的建议宽度作为起始宽度进⾏计算
// ⽽在渲染阶段中它将使⽤布局阶段的结果作为起始宽度并再⼀次将该宽度分配给各个列。这可能会带来让⼈⾮常惊讶的结果

#Preview("不指定列数根据屏幕宽度") { 
	let columns = [
		GridItem(.adaptive(minimum: 80))
	]
	
	ScrollView { 
		LazyVGrid(columns: columns, spacing: 10) {
			ForEach(0..<50) { i in
				RoundedRectangle(cornerRadius: 8)
					.fill(.clear)
					.background(Color.blue.opacity(0.3))
					.frame(height: 80)
			}
		}
	}
}

// MARK: - SwiftUI 编程思想中的计算例子
#Preview("SwiftUI 编程思想中的计算例子") { 
	LazyVGrid(columns: [
		GridItem(.flexible(minimum: 60)),
		GridItem(.flexible(minimum: 120))
	], spacing: 10, content: {// spacing 参数是行间隔
		ForEach(0..<2) { i in
			GeometryReader { proxy in
				RoundedRectangle(cornerRadius: 10)
					.fill(.purple)
					.overlay { 
						Text(verbatim: "\(proxy.size)")
					}
			}
		}
	})
	.frame(width: 200)
	.border(.teal)
}

// ⚠️那个减去 10 是因为默认列间距为 10
// 虽然两列的最⼩宽度加起来也可以轻松适配到 200 的可⽤宽度中去，但是 LazyVGrid 不仅渲染出了边界它甚⾄都没能在 200 宽度的中⼼进⾏渲染
// 让我们⼀步步看看 LazyVGrid 的排序算法来理解到底发⽣了什么
// 1.我们从剩余宽度 200 开始⾸先减去 10 的间隔得到 190
// 2.对于第⼀列我们将 190 的宽度除以剩余的列数 2 得到 95,因为第⼀列的最⼩宽度设定为了60所以95并不会被限制于是剩下的宽度保持在95
// 3.第⼆列使⽤这个 95 的剩余宽度但它的最⼩宽度需要是 120 所以它使⽤ 120 作为宽度
// 但是这并不是我们看到的 LazyVGrid 渲染的结果：渲染出的第⼀列宽度是 108 第⼆列宽度 120，⽽我们计算得到的应该是 95 和 120 这就是第⼆遍布局过程发挥作⽤的地⽅
// 1.在第⼀遍布局中计算得到的⽹格整体宽度是 95 + 10 + 120 = 225。具有 200 固定框架的 frame 将把 LazyVGrid 放置在正中，所以它会向左边偏移 (225 - 200) / 2 = 12.5 的距离(超出红色边框的黄色部分)
// 当⽹格需要渲染⾃⼰的时候它会再次执⾏列布局算法但这次的初始剩余宽度会从 225 开始
// 第⼆遍布局从 225 开始，先减去 10 的间隔剩下 215。于是第⼀列变成了 215 除以剩余列数 2 四舍五⼊后得到了 108
// 剩余的宽度是 215 减去 108 结果是 107 ⽐第⼆列设定的最⼩宽度 120 还⼩，所以该列将使⽤ 120 作为宽度,这与我们上⾯看到的示例完全吻合
// 除了令⼈感到惊讶的宽度外我们现在也能解释为什么⽹格的渲染偏离了固定 frame 中⼼的情况了：
// 因为⽹格外的 frame 是按照⽹格的原始宽度 225 进⾏计算的，但是⽹格现在会将⾃⼰的整体宽度渲染为 108 + 10 + 120 = 238 所以⽹格呈现出偏离中⼼ 7 point 的现象

// MARK: - 下面的代码用来调试上述布局行为
struct GridDebugView: View {
	let columns = [
		GridItem(.flexible(minimum: 60)),	// 默认 spacing = 10
		GridItem(.flexible(minimum: 120)) 	// 默认 spacing = 10
	]
	
	let columns1 = [
		GridItem(.flexible(minimum: 60)),	// 默认 spacing = 10
		GridItem(.flexible(minimum: 60)) 	// 默认 spacing = 10
	]
	
	var body: some View {
		VStack(spacing: 50) {
			Text("LazyVGrid 布局调试 Demo")
			
			ZStack {
				LazyVGrid(columns: columns) {
					ForEach(0..<2) { index in
						GeometryReader { geo in
							RoundedRectangle(cornerRadius: 16)
								.fill(index == 0 ? .purple : .clear)// 设定透明方便查看
								.overlay(
									Text("列 \(index + 1)\n宽度: \(Int(geo.size.width))")
										.font(.caption)
										.multilineTextAlignment(.center)
								)
						}
						.frame(height: 40)
						.border(Color.green)
					}
				}
				.background(// LazyVGrid 黄色背景
					GeometryReader { geo in
						Color.yellow
							.overlay(
								Text("Grid 渲染宽度: \(Int(geo.size.width))")
									.font(.caption)
									.padding(.top, 60),
								alignment: .topLeading
							)
					}
				)
			}
			.frame(width: 200)	// 父容器红色框框固定宽度 = 200
			.border(.red)		// 父容器红色边框
			
			ZStack {
				LazyVGrid(columns: columns1) {
					ForEach(0..<2) { index in
						GeometryReader { geo in
							RoundedRectangle(cornerRadius: 16)
								.fill(index == 0 ? .purple : .blue)
								.overlay(
									Text("列 \(index + 1)\n宽度: \(Int(geo.size.width))")
										.font(.caption)
										.multilineTextAlignment(.center)
								)
						}
						.frame(height: 40)
						.border(Color.green)
					}
				}
				.background(// LazyVGrid 黄色背景
					GeometryReader { geo in
						Color.yellow
							.overlay(
								Text("Grid 渲染宽度: \(Int(geo.size.width))")
									.font(.caption)
									.padding(.top, 60),
								alignment: .topLeading
							)
					}
				)
			}
			.frame(width: 200)	// 父容器红色框框固定宽度 = 200
			.border(.red)		// 父容器红色边框
		}
		.padding()
	}
}

#Preview {
	GridDebugView()
}

// MARK: - 这里对布局行为进行最终讲解
// ✨ 第一遍布局（确定 ideal width）
// 1.初始父视图给出最大宽度 200
// 2.扣掉默认间距 10 剩下 190
// 3.分配给两列
//		1.第一列：190 / 2 = 95  >= min(60)
// 		2.第二列：余下 95 < min(120) → 120
// ✨ 第一遍得到 ideal 宽度 95 + 10 + 120 = 225
// ✨ LazyVGrid 认为自己理想上需要 225 但是父视图只有 200
// ✨ 第二遍布局
// 开始宽度变成 225 扣掉默认间距 10 剩下 215
// 重新分配列 215 / 2 = 107.5 四舍五入 108
// 剩余 107 小于设定的 120 取 120
// 最终就是 108 + 10 + 120 = 238
// 但是父视图认为它应该是 225 所以会便宜 6.5 - 7

// MARK: - ViewThatFits 规则
// 当我们想要根据不同的建议尺⼨显示不同的视图时可以使⽤ ViewThatFits
// 它接受多个⼦视图并显示第⼀个能适配建议尺⼨的⼦视图
// ViewThatFits 的⼯作⽅式是向每个⼦视图建议 nil 尺⼨来获取⼦视图的理想尺⼨
// 然后显示 (按照出现在代码中的) 第⼀个理想尺⼨能适配到建议尺⼨之中的⼦视图
// 如果所有⼦视图都⽆法适配那么它选取最后的⼀个⼦视图
