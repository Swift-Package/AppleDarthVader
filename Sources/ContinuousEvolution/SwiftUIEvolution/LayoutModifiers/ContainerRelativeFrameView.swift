//
//  ContainerRelativeFrameView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/19.
//

// 在 SwiftUI 中使用 ContainerRelativeFrame 布局视图 - https://www.youtube.com/watch?v=DudvesMYAAY

import SwiftUI

struct ContainerRelativeFrameView: View {
    var body: some View {
        Color.red
            // .frame(width: 200, height: 400)// 1.直接指定Frame
            // .containerRelativeFrame(.horizontal, alignment: .leading)// 2.指定位置
            // .containerRelativeFrame(.vertical, alignment: .bottom)   // 3.指定位置
            // .containerRelativeFrame([.horizontal, .vertical], alignment: .topLeading)// 4. 指定位置
            .containerRelativeFrame([.horizontal, .vertical]) { dimension, _ in
                dimension / 2
            }// 5.通过容器布局修饰符
    }
}

#Preview {
    ContainerRelativeFrameView()
}

// MARK: - 不同维度不同占用比例
struct ContainerRelativeFrameView1: View {
    
    let ratio = 0.33333
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                Color.red
                    .containerRelativeFrame(.horizontal) { dimension, _ in
                        dimension * ratio
                    }
                Color.black
                    .containerRelativeFrame(.horizontal) { dimension, _ in
                        dimension * (1 - ratio)
                    }
            }
        }
        .padding()
        .frame(height: 150)
        .scrollDisabled(true)
    }
}

#Preview {
    ContainerRelativeFrameView1()
}

// MARK: - 平均分割并指定占用比例
struct CountAndSpanView: View {
    
    var colors: [Color] = [.red, .green, .yellow, .blue, .cyan, .purple]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(colors, id: \.self) { color in
                    color
                        // .containerRelativeFrame(.horizontal)// 1.让每个色块占用一个屏幕宽度
                        // .containerRelativeFrame(.horizontal, count: 4, spacing: 10)// 2.平分4个
                        // .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 10)// 3.平分4份但是每个占用3份
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 10)// 4.平分4份但是每个占用3份并且调整比例
                }
            }
        }
        .frame(height: 300)
    }
}

#Preview {
    CountAndSpanView()
}
