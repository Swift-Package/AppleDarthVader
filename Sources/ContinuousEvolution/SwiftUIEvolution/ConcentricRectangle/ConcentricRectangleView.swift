//
//  ConcentricRectangleView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

import SwiftUI

fileprivate struct ConcentricRectangleView: View {
    var body: some View {
		ZStack {
			VStack(alignment: .leading, spacing: 16) {
				ConcentricRectangle()
					.frame(width: 300, height: 300)
				
				Button {
					
				} label: {
					Text("Play Episode")
						.font(.title3.bold())
						.foregroundStyle(.white)
						.padding()
						.background(.indigo)
				}
			}
			.padding(20)// 这里的参数与下面的 cornerRadius 参数将决定靠近的距离能否触发圆角效果
		}
		.background(.secondary.opacity(0.2))
		.containerShape(.rect(cornerRadius: 40, style: .continuous))
    }
}

#Preview {
	ConcentricRectangleView()
}

fileprivate struct ConcentricRectangleView1: View {
	
	@State private var isShow = false
	
	var body: some View {
		ZStack {
			VStack(alignment: .leading, spacing: 16) {
				// minimum 表示离得太远的话提供一个最小的圆角值得
				// isUniform 表示是否将圆角实现到4个边
				ConcentricRectangle(corners: .concentric(minimum: 12), isUniform: true)
					.frame(width: 300, height: 300)
				
				Image("X")
					.resizable()
					.frame(width: 300, height: 300)
					.background(.black)
					.clipShape(.rect(corners: .concentric, isUniform: true))// 图片的圆角
				
				Button {
					isShow = true
				} label: {
					Text("Play Episode")
						.font(.title3.bold())
						.foregroundStyle(.white)
						.padding()
						.background(.indigo)
				}
			}
			.padding(20)// 这里的参数与下面的 cornerRadius 参数将决定靠近的距离能否触发圆角效果
		}
		.background(.secondary.opacity(0.2))
		.containerShape(.rect(cornerRadius: 40, style: .continuous))
		.sheet(isPresented: $isShow) {
			ConcentricRectangle()
				.fill(.indigo)
				.padding(20)
				.ignoresSafeArea()
				.presentationDetents([.medium])
		}
	}
}

#Preview {
	ConcentricRectangleView1()
}
