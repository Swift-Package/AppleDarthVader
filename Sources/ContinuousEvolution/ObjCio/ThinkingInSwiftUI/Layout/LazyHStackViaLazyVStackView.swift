//
//  LazyHStackViaLazyVStackView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

fileprivate struct LazyHStackViaLazyVStackView: View {
	
	var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(0..<100) { i in
					Text("View \(i)")
						.padding(.vertical)
						.onAppear {
							print("View \(i) appeared")
						}
				}
			}
		}
	}
}

#Preview {
	LazyHStackViaLazyVStackView()
}


// 除了主要轴和次要轴不同之外 LazyHStack 和 LazyVStack 拥有相同的⾏为模式,懒加载的堆栈和那些⾮懒加载的普通堆栈在布局⾏为上来说是⼀样的,它们最后的尺⼨都是所有⼦视图框架的并集
// 但是懒加载的堆栈不会尝试在主要轴上为⼦视图进⾏可⽤空间的分配
// 举例来说 LazyHStack 只会把 nil ⨉ proposedHeight 提供给它的⼦视图也就是说⼦视图会使⽤它们⾃⼰的理想宽度
// 要计算 LazyVStack 的⾼度是相当困难的⼀件事,事实上如果 LazyVStack 被内嵌在⼀个滚动视图中时它会只在需要时才按需创建⼦视图 (对于宽度 LazyVStack 将直接接受被建议的宽度)
// 随着不断滚动 print 会打印出越来越多的信息,渲染树中的视图也被按需创建
// 因此就像 List ⼀样 LazyVStack 也许要基于已经布局的⼦视图来估算⾃⼰的⾼度并在新的⼦视图出现在屏幕上时更新⾃⼰的尺⼨
