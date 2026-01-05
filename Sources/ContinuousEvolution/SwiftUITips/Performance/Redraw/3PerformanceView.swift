//
//  3PerformanceView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

import SwiftUI
import Charts

// MARK: - 使用 @Observable 宏避免无效的视图重绘
@Observable
fileprivate class ModelData {
	var counter = 0
	var chart: [Double] = [0.3, 0.7, 0.5, 0.9, 0.4]
}

// MARK: - 模拟昂贵的视图更新
fileprivate struct SomeExpensiveView: View {
	
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
			model.chart.reverse()
		}
	}
}

fileprivate struct PerformanceView: View {
	
	@State private var model = ModelData.init()
	
	var body: some View {
		VStack(spacing: 16) {
			Text("Couter Value: \(model.counter)")
			
			SomeExpensiveView(model: $model)
				.frame(height: 200)
			
			
			Button("Update Counter") {
				model.counter += 1
			}
			
			Button("Reverse Chart Data") {
				model.chart.reverse()
			}
		}
		.monospaced()
		.padding()
	}
}

#Preview("Observable 宏") {
	PerformanceView()
}
