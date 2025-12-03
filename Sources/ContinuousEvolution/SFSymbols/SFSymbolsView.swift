//
//  SFSymbolsView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

import SwiftUI

fileprivate struct SFSymbolsView: View {
	
	@State private var notificationsEnabled = true
	
    var body: some View {
		VStack(spacing: 16) { 
			HStack {
				Text(verbatim: "Gradient")
				Image(systemName: "star")
					.imageScale(.large)
					.foregroundStyle(LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottom))
			}
			
			// MARK: - 层级模式
			HStack {
				Text(verbatim: "Hierarchical")
				Image(systemName: "thermometer.snowflake")
				Image(systemName: "thermometer.snowflake")
					.foregroundStyle(.indigo)
			}
			.symbolRenderingMode(.hierarchical)
			
			// MARK: - 调色板模式
			HStack { 
				Text(verbatim: "Palette")
				Image(systemName: "thermometer.snowflake")
					.symbolRenderingMode(.palette)
					.foregroundStyle(.blue, .teal, .gray)
				
				Image(systemName: "thermometer.snowflake")
					.foregroundStyle(.blue, .teal, .gray)// 可以不指定渲染模式为调色板模式直接使用前景色
				
				Image(systemName: "thermometer.snowflake")
					.foregroundStyle(.blue, .gray)// 我们只为定义三个层级的符号指定两种颜色则二级和三级将使用相同的颜色
			}
			
			// MARK: - 预定义多色模式
			HStack {
				Text(verbatim: "Multicolor")
				Image(systemName: "thermometer.snowflake")
				Image(systemName: "thermometer.sun.fill")
					.foregroundStyle(.white)// 预定义多色模式下 foregroundStyle 无效
			}
			.symbolRenderingMode(.multicolor)
			
			// MARK: - 变量值
			HStack {
				Image(systemName: "speaker.wave.3", variableValue: 0)
				Image(systemName: "speaker.wave.3", variableValue: 0.3)
				Image(systemName: "speaker.wave.3", variableValue: 0.6)
				Image(systemName: "speaker.wave.3", variableValue: 0.9)
			}
			
			// MARK: - 变体
			HStack {
				Image(systemName: "heart")
				Image(systemName: "heart")
					.symbolVariant(.slash)
				Image(systemName: "heart")
					.symbolVariant(.fill)
				Image(systemName: "heart")
					.symbolVariant(.circle)
			}
			
			Button {
				withAnimation {
					notificationsEnabled.toggle()
				}
			} label: {
				Label("Toggle notifications", systemImage: notificationsEnabled ? "bell" : "bell.slash")
			}
			.contentTransition(
				.symbolEffect(.replace.magic(fallback: .replace))
			)
		}
    }
}

#Preview {
	SFSymbolsView()
		.preferredColorScheme(.dark)
}
