//
//  HStackViaVStackView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

fileprivate struct HStackViaVStackView: View {
    var body: some View {
		VStack { 
			HStack(spacing: 0) {
				Color.cyan
				Text("Hello, World!")
				Color.teal
			}
			
			// 空间不足够的情况文本选择换行
			HStack(spacing: 0) {
				Color.cyan
				Text("Hello, World!")
				Color.teal
			}
			.frame(width: 100)
			
			// 空间不足使用 fixedSize 将导致超出边界
			HStack(spacing: 0) {
				Color.cyan
				Text("Hello, World!")
					.fixedSize()
				Color.teal
			}
			.frame(width: 40)
		}
		
		// 空间不足使用布局优先级
		HStack(spacing: 0) {
			Color.cyan
				.layoutPriority(2)
			Text("Hello, World World!")
				.layoutPriority(4)// 优先级最高
			Color.teal
				.layoutPriority(1)
		}
		.frame(width: 100)
		.background(.red)
    }
}

#Preview {
	HStackViaVStackView()
}

// 导致文本选择换行的原因和 HStack 向⼦视图分配可⽤宽度的算法有关
// ⾸先 HStack 会确定它的⼦视图们的灵活性,两个颜⾊视图是⽆限灵活的不管向它们提供什么样的尺⼨它们都会欣然接受
// 但是 Text 的宽度可能介于 0 到它的理想宽度之间但是绝对不可能超过理想宽度上限
// HStack 根据⼦视图的灵活性从低到⾼进⾏排序,它会跟踪所有的剩余⼦视图和可⽤的剩余宽度
// 只要还有剩余的⼦视图 HStack 就会把剩余的宽度除以⼦视图的数量然后把结果作为建议宽度提供给这个⼦视图
// 我们假设⽂本的理想宽度是 100 当我们向 HStack 提供 180⨉180 时因为剩余三个⼦视图它⾸先把宽度 180 除以 3 也就是 60 提供给灵活性最低的视图也就是 Text
// 接下来 Text 根据需要进⾏换⾏或者裁断。我们假设⽂本的尺⼨结果为 50⨉40 (插⼊了⼀个换⾏) 于是两个矩形颜⾊分别会得到 130/2 和 65/1 的宽度
// 由于这个算法就算⽂本原本其实有⾜够的空间显示在⼀⾏它也还是会进⾏换⾏
// MARK: - 几种解决方案
// 1.⾸先我们可以对 Text 使⽤ .fixedSize 这样⼀来 Text 将忽视掉建议尺⼨并始终使⽤理想尺⼨
// 但是⼀旦 HStack 得到的建议尺⼨宽度⽐⽂本的理想宽度还要⼩时⽂本仍然会按照全宽进⾏渲染
// 也就是说这种情况下⽂本的宽度要⼤于建议宽度⽂本将被渲染到边界之外
// 2.另⼀种替代选择是使⽤ .layoutPriority 修饰器给 Text 设定⼀个布局优先级
// 这会让 HStack ⾸先把全部剩余宽度提供给 Text 然后再将除去 Text 之外的剩余宽度提供给两个颜⾊,这样就算没有⾜够的空间让⽂本以理想尺⼨渲染⾃⼰⽂本也会正确进⾏换⾏
// 为了更好地理解堆栈的布局算法这⾥提供⼀个⾮正式的描述 (依然以 HStack 为例)
// 1.通过向每个⼦视图提供 0 ⨉ proposedHeight 和 .infinity ⨉ proposedHeight 作为建议尺⼨来确定每个⼦视图的灵活性,这个向⼦视图提议多个尺⼨的过程也被称为探测 (probing)。灵活性被定义为两个结果宽度的差值
// 2.将所有⼦视图按照它们的布局优先级进⾏分组
// 3.从收到的建议宽度中减去所有⼦视图的最⼩宽度以及它们之间 (由HStack 所定义) 的间距把这个结果称为 remainingWidth (如果建议宽度为 nil 的话这个值也是 nil)
// 4.当等待布局的分组还有剩余时
//		1.取出布局优先级最⾼的分组
//		2.将这个分组中所有⼦视图的最⼩宽度加回到 remainingWidth 中去
//		3.当这个分组中还有剩余的视图时
//			1.选取灵活性最⼩的视图
//			2.向这个视图提供建议宽度 (remainingWidth / numberOfRemainingViews) ⨉ proposedHeight
//			3.从 remainingWidth ⾥减去视图所报告的宽度
// 尽管这个算法没有写在正式的⽂档⾥，但⾃从我们在 2020 年本书的第⼀版中⾸次描述以来它并没有发⽣过变化因此我们认为它是稳定的
// 通过将实现了 sizeThatFits ⽅法的⾃定义形状放⼊到堆栈中并记录建议尺⼨和报告尺⼨⾄少可以对布局⾏为进⾏部分验证
