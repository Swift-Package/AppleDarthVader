//
//  2PerformanceView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

import SwiftUI
import Charts

fileprivate struct ModelData {
	var counter = 0
	var chart: [Double] = [0.3, 0.7, 0.5, 0.9, 0.4]
}

// MARK: - 实现 Equatable 协议避免无效重绘
fileprivate struct SomeExpensiveView: View, @MainActor Equatable {
	
	static func == (lhs: SomeExpensiveView, rhs: SomeExpensiveView) -> Bool {
		lhs.model.chart == rhs.model.chart
	}
	
	@Binding var model: ModelData
	
	var body: some View {
		let _ = print("Body Called")
		Chart {
			ForEach(model.chart.indices, id: \.self) { index in
				LineMark(x: .value("", index), y: .value("", model.chart[index]))
					.interpolationMethod(.catmullRom)
					.foregroundStyle(.red)
			}
		}
		.onTapGesture {
			model.chart.reverse()// 通过 Binding 修改数据
		}
	}
}

fileprivate struct PerformanceView: View {
	
	@State private var model = ModelData.init()
	
	var body: some View {
		VStack(spacing: 16) {
			Text("Couter Value: \(model.counter)")
			
			// MARK: - 下面这种简单绑定将会导致 SomeExpensiveView 每次重绘
			// SomeExpensiveView(model: $model)
				// .equatable()// 使用 Equatable 修饰器,当视图的新值与其旧值相同时阻止视图更新其子视图
				// .frame(height: 200)
			
			// MARK: - 创建自定义绑定
			let customBinding = Binding {
				model
			} set: {
				model = $0
				// 甚至自定义仅需要更新逻辑
				// model.chart = $0.chart
			}
			
			SomeExpensiveView(model: customBinding)
				.equatable()
				.frame(height: 200)
			
			
			Button("Update Counter") {
				model.counter += 1// 这个属性更新也导致 SomeExpensiveView 的重绘,虽然 SomeExpensiveView 未使用 counter 属性
			}
			
			Button("Reverse Chart Data") {
				model.chart.reverse()
			}
		}
		.monospaced()
		.padding()
	}
}

#Preview("实现 Equatable 并使用自定义绑定避免无效重绘") {
	PerformanceView()
}
