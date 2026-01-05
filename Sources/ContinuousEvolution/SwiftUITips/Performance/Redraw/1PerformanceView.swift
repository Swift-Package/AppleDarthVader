//
//  1PerformanceView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

// SwiftUI 性能优化技巧 - 使用 Equatable 避免无效重绘 - https://www.youtube.com/watch?v=_wYQ1_M_YWw&t=19s

import SwiftUI
import Charts

fileprivate struct ModelData {
	var counter = 0
	var chart: [Double] = [0.3, 0.7, 0.5, 0.9, 0.4]
}

fileprivate struct SomeExpensiveView: View {
	
	var model: ModelData
	
	var body: some View {
		let _ = print("Body Called")
		Chart {
			ForEach(model.chart.indices, id: \.self) { index in
				LineMark(x: .value("", index), y: .value("", model.chart[index]))
					.interpolationMethod(.catmullRom)
					.foregroundStyle(.red)
			}
		}
	}
}

fileprivate struct PerformanceView: View {
	
	@State private var model = ModelData.init()
	
    var body: some View {
		VStack(spacing: 16) {
			Text("Couter Value: \(model.counter)")
			
			SomeExpensiveView(model: model)
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

#Preview {
	PerformanceView()
}

// MARK: - 实现 Equatable 协议避免无效重绘
fileprivate struct SomeExpensiveView1: View, @MainActor Equatable {
	
	static func == (lhs: SomeExpensiveView1, rhs: SomeExpensiveView1) -> Bool {
		lhs.model.chart == rhs.model.chart
	}
	
	var model: ModelData
	
	var body: some View {
		let _ = print("Body Called")
		Chart {
			ForEach(model.chart.indices, id: \.self) { index in
				LineMark(x: .value("", index), y: .value("", model.chart[index]))
					.interpolationMethod(.catmullRom)
					.foregroundStyle(.red)
			}
		}
	}
}

fileprivate struct PerformanceView1: View {
	
	@State private var model = ModelData.init()
	
	var body: some View {
		VStack(spacing: 16) {
			Text("Couter Value: \(model.counter)")
			
			SomeExpensiveView1(model: model)
				.equatable()// 使用 Equatable 修饰器,当视图的新值与其旧值相同时阻止视图更新其子视图
				.frame(height: 200)
			
			Button("Update Counter") {
				model.counter += 1// 这个属性更新也导致 SomeExpensiveView1 的重绘,虽然 SomeExpensiveView1 未使用 counter 属性
			}
			
			Button("Reverse Chart Data") {
				model.chart.reverse()
			}
		}
		.monospaced()
		.padding()
	}
}

#Preview("实现 Equatable 避免无效重绘") {
	PerformanceView1()
}
