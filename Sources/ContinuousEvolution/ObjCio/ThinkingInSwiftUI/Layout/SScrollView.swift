//
//  SScrollView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/21.
//

import SwiftUI

// MARK: - 滚动视图的两个布局行为
// 1.滚动视图本身
// 在滚动轴的⽅向上会接受⽗视图所提供的建议尺⼨而在另⼀个轴上则使⽤它的内容的尺⼨
// ⽐如如果我们把⼀个垂直的滚动视图作为根视图的话，它的⾼度就是会整个安全区域，宽度则取决于滚动内容
// 2.在滚动⽅向上
// 滚动视图本质上具有⽆限的空间,它的内容在这个轴上也可以⽆限增⻓
// 因此滚动视图在它的滚动轴上将使⽤ nil 作为建议尺⼨,在另外的轴上则将滚动视图⾃身所收到的尺⼨不加修改地提供给内容视图

fileprivate struct SScrollView: View {
    var body: some View {
		ScrollView {
			Image("logo")// 如果这个图片100 x 100 那么 ScrollView 的宽度就是 100
				.resizable()
				.aspectRatio(contentMode: .fit)
			Text("This is a longer text")
		}
    }
}

#Preview {
	SScrollView()
}

// 默认情况下当我们为滚动视图的内容设定多个视图时 (就像我们上⾯做的这样) 不管滚动⽅向如何这些⼦视图都会被放在⼀个隐式的 VStack 中
// 为了简化上面这个例⼦我们假设滚动视图接受到的建议尺⼨是 320⨉480
// 它接下来会把 320⨉nil 提供给它的两个⼦视图然后将它们分别放到滚动容器中,滚动视图本身的⾼度将始终是收到的建议⾼度 480
// 当滚动视图中存在⽂本时有时候⽂本会指定换⾏,这样⽂本的宽度就有可能⽐收到的建议宽度要窄⼀些
// 如果滚动视图中没有其他的⼦视图将被建议的宽度接受为⾃⼰的宽度时就可能会导致滚动视图的宽度要⽐建议宽度⼩⼀些的情况
// 想要修复这个问题我们可以向 Text 添加 .frame(maxWidth: .infinity)
// 对于 Text 之外那些不⼀定要接受建议宽度的其他视图也可以同样处理
// 当我们把⼀个形状放⼊滚动视图中时结果可能会让⼈⼤吃⼀惊。SwiftUI 中内置的形状的理想尺⼨都是 10⨉10
// 这是由于 ProposedViewSize 上 .replacingUnspecifiedDimensions(by:) 的默认参数是10⨉10
// 因为滚动视图会在滚动轴上提议 nil，所以形状在这个轴上就将使⽤理想尺⼨的 10
// 如果我们想要改变这个⾏为可以使⽤ .frame(height:) 或 .frame(idealHeight:) 来明确指定⼀个⾼度或者也可以⽤ .aspectRatio 基于另⼀个轴来确定⾼度
