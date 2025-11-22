//
//  GeometryReaderView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import SwiftUI

struct GeometryReaderView: View {
    
    let colors: [Color] = [.red, .orange, .yellow]
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    ForEach(colors, id: \.self) { color in
                        color
                            .frame(height: proxy.size.height / CGFloat(colors.count))
                    }
                }
            }
            .padding()
            
            // MARK: - 上面的代码可以用下面的 containerRelativeFrame 简化
            VStack {
                ForEach(colors, id: \.self) { color in
                    color
                        .containerRelativeFrame(.vertical, count: colors.count, spacing: 0)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GeometryReaderView()
}

// MARK: - SwiftUI 编程思想
// ⼏何读取器本身也算⼀个视图它会始终接受被建议的尺⼨,并将这个尺⼨通过⼀个 GeometryProxy 报告给它的视图构建闭包
// 通过这个值我们就可以获取到⼏何读取器的尺⼨了
// GeometryProxy 还可以让我们访问当前的安全区域的缩进值 (inset) 以及视图在特定坐标空间中的 frame 值,它还可以⽤来解析锚点 anchor
// 不过在阅读 Stack Overflow 或者浏览社交媒体时 GeometryReader 是那些经常引起麻烦的视图之⼀
// 这是因为⼏何读取器的功能不仅仅只是“阅读”它也总是会把⾃⼰的⼤⼩变成建议尺⼨
// ⽐如我们想要把 GeometryReader 放到某个 Text 视图外围来测量它的宽度时将会影响到 Text 周围的布局
// 如果我们不想让⼏何读取器影响布局有下⾯两种⽅法可以做到
// 1.当我们把⼀个完全灵活的视图放到 GeometryReader ⾥它就不会影响布局,⽐如对于滚动视图来说它本身就会变成建议尺⼨的⼤⼩，我们可以把它放到 GeometryReader ⾥来获取建议尺⼨
// 2.当把⼏何读取器放到 background 或者 overlay 修饰器中它不会影响主视图的尺⼨, 所以在 background 或 overlay 中我们可以使⽤ GeometryProxy 来读取和视图⼏何特性相关的不同的值,因为主要⼦视图的尺⼨会被当作建议尺⼨给到次要⼦视图 (也就是⼏何读取器) 所以这种做法在测量视图的⼤⼩时⾮常有效我们会在进阶布局⼀章中看到更多例⼦
// 和其他容器视图相⽐⼏何读取器是⾮常特殊的存在它不提供对⻬参数,在默认情况下它会将⼦视图放置在顶边和前边 (top-leading) 位置 —— ⽽除了 ScrollView 的其他所有容器视图默认会使⽤居中对⻬
