//
//  4PerformanceView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/4.
//

import SwiftUI
import Charts
import Combine

// MARK: - 兼容 iOS 16 的情况下仅传递需要的属性以避免重绘
fileprivate class ModelData: ObservableObject {
	@Published var counter = 0
	@Published var chart: [Double] = [0.3, 0.7, 0.5, 0.9, 0.4]
}

fileprivate struct SomeExpensiveView: View {
	
	@Binding var chart: [Double]
	
	var body: some View {
		let _ = print("Body Called")
		Chart {
			ForEach(chart.indices, id: \.self) { index in
				LineMark(x: .value("", index), y: .value("", chart[index]))
					.interpolationMethod(.catmullRom)
					.foregroundStyle(.red)
			}
		}
		.onTapGesture {
			chart.reverse()
		}
	}
}

fileprivate struct PerformanceView: View {
	
	@StateObject private var model = ModelData.init()
	
	var body: some View {
		VStack(spacing: 16) {
			Text("Couter Value: \(model.counter)")
			
			SomeExpensiveView(chart: $model.chart)
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

#Preview {
	PerformanceView()
}
