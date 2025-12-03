//
//  LineMarkView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/3.
//

// 邮件 - https://substack.com/@antongubarenko

import SwiftUI
import Charts

fileprivate struct HumidityRate: Identifiable {
	let humidity: Int
	let date: Date
	
	var id: Date { date }
	
	init(minutesOffset: Double, humidity: Int) {
		self.date = Date().addingTimeInterval(minutesOffset * 60)
		self.humidity = humidity
	}
}

fileprivate extension HumidityRate {
	static var samples: [HumidityRate] {
		[
			.init(minutesOffset: -3, humidity: 10),
			.init(minutesOffset: -2, humidity: 10),
			.init(minutesOffset: -1, humidity: 10),
			.init(minutesOffset: 0, humidity: 20),
			.init(minutesOffset: 1, humidity: 30),
			.init(minutesOffset: 2, humidity: 40),
			.init(minutesOffset: 3, humidity: 50),
			.init(minutesOffset: 4, humidity: 40),
			.init(minutesOffset: 5, humidity: 30),
			.init(minutesOffset: 6, humidity: 20),
			.init(minutesOffset: 7, humidity: 10)
		]
	}
}

extension Color {
	static func colorForIndex(_ humidity: Int) -> Color {
		switch humidity {
		case 0..<20: return .green
		case 20..<50: return .yellow
		case 50..<70: return .orange
		case 70...80: return .red
		default: return .purple
		}
	}
}

fileprivate struct LineMarkView: View {
	
	let data: [HumidityRate]
	
    var body: some View {
		Chart(data, id: \.date) { rate  in
			LineMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			
			PointMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
		}
		.frame(height: 400)
		.padding()
    }
}

#Preview("普通折线图") {
	let data: [HumidityRate] = HumidityRate.samples
	LineMarkView(data: data)
}

// MARK: - 渐变折线图
fileprivate struct ColorLineMarkView: View {
	
	let data: [HumidityRate]
	
	var body: some View {
		Chart(data, id: \.date) { rate  in
			LineMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.interpolationMethod(.catmullRom)
			.foregroundStyle(LinearGradient(colors: data.compactMap({Color.colorForIndex($0.humidity)}), startPoint: .leading, endPoint: .trailing))
			
			PointMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.foregroundStyle(Color.colorForIndex(rate.humidity))
			.annotation(position: .top) {
				Text("\(rate.humidity)")
					.font(.headline)
					.fontWeight( rate.date < Date() ? .regular: .bold)
					.opacity( rate.date < Date() ? 0.5 : 1.0)
			}
		}
		.frame(height: 400)
		.padding()
	}
}

#Preview("渐变折线图") {
	let data: [HumidityRate] = HumidityRate.samples
	ColorLineMarkView(data: data)
}

// MARK: - 渐变填充折线图
fileprivate struct ColorFillLineMarkView: View {
	
	let data: [HumidityRate]
	
	var body: some View {
		Chart(data, id: \.date) { rate  in
			//Area highlight
			AreaMark(x: .value("", rate.date),
					 y: .value("", rate.humidity))
			.foregroundStyle(LinearGradient(colors:
												data.compactMap({
				Color.colorForIndex($0.humidity)
			}),
											startPoint: .leading,
											endPoint: .trailing))
			.interpolationMethod(.catmullRom)
			
			LineMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.interpolationMethod(.catmullRom)
			.foregroundStyle(LinearGradient(colors: data.compactMap({Color.colorForIndex($0.humidity)}), startPoint: .leading, endPoint: .trailing))
			
			PointMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.foregroundStyle(Color.colorForIndex(rate.humidity))
			.annotation(position: .top) {
				Text("\(rate.humidity)")
					.font(.headline)
					.fontWeight( rate.date < Date() ? .regular: .bold)
					.opacity( rate.date < Date() ? 0.5 : 1.0)
			}
		}
		.frame(height: 400)
		.padding()
	}
}

#Preview("渐变填充折线图") {
	let data: [HumidityRate] = HumidityRate.samples
	ColorFillLineMarkView(data: data)
}

// MARK: - 轴线折线图
fileprivate struct AxisLineMarkView: View {
	
	@State private var selectedX: Date? = nil
	
	let data: [HumidityRate]
	
	var body: some View {
		Chart(data, id: \.date) { rate  in
			AreaMark(x: .value("", rate.date),
					 y: .value("", rate.humidity))
			.foregroundStyle(LinearGradient(colors:
												data.compactMap({
				Color.colorForIndex($0.humidity)
			}),
											startPoint: .leading,
											endPoint: .trailing))
			.interpolationMethod(.catmullRom)
			
			LineMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.interpolationMethod(.catmullRom)
			.foregroundStyle(LinearGradient(colors: data.compactMap({Color.colorForIndex($0.humidity)}), startPoint: .leading, endPoint: .trailing))
			
			PointMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.foregroundStyle(Color.colorForIndex(rate.humidity))
			.annotation(position: .top) {
				Text("\(rate.humidity)")
					.font(.headline)
					.fontWeight( rate.date < Date() ? .regular: .bold)
					.opacity( rate.date < Date() ? 0.5 : 1.0)
			}.annotation(position: .automatic, alignment: .center, spacing: -9.0) {
				Circle()
					.stroke(Color.black.opacity(0.5), lineWidth: 1)
			}
			
			if let selectedX {
				RuleMark(x: .value("Selected", selectedX))
					.annotation(position: .automatic) {
						VStack(spacing: 0) {
							Text(selectedX, style: .time)
						}
					}
			}
		}
		.chartXSelection(value: $selectedX)
		.chartYScale(domain: 0...(min(100, data.map(\.humidity).max() ?? 0) + 10))// 删除这行可以缩放
		.frame(height: 400)
		.padding()
	}
}

#Preview("轴线折线图") {
	let data: [HumidityRate] = HumidityRate.samples
	AxisLineMarkView(data: data)
}

// MARK: - 轴线折线图
fileprivate struct AxisTitleLineMarkView: View {
	
	@State private var selectedX: Date? = nil
	
	let data: [HumidityRate]
	
	var body: some View {
		Chart(data, id: \.date) { rate  in
			AreaMark(x: .value("", rate.date),
					 y: .value("", rate.humidity))
			.foregroundStyle(LinearGradient(colors:
												data.compactMap({
				Color.colorForIndex($0.humidity)
			}),
											startPoint: .leading,
											endPoint: .trailing))
			.interpolationMethod(.catmullRom)
			
			LineMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.interpolationMethod(.catmullRom)
			.foregroundStyle(LinearGradient(colors: data.compactMap({Color.colorForIndex($0.humidity)}), startPoint: .leading, endPoint: .trailing))
			
			PointMark(
				x: .value("", rate.date),
				y: .value("", rate.humidity)
			)
			.foregroundStyle(Color.colorForIndex(rate.humidity))
			.annotation(position: .top) {
				Text("\(rate.humidity)")
					.font(.headline)
					.fontWeight( rate.date < Date() ? .regular: .bold)
					.opacity( rate.date < Date() ? 0.5 : 1.0)
			}.annotation(position: .automatic, alignment: .center, spacing: -9.0) {
				Circle()
					.stroke(Color.black.opacity(0.5), lineWidth: 1)
			}
			
			if let selectedX {
				RuleMark(x: .value("Selected", selectedX))
					.annotation(position: .automatic) {
						VStack(spacing: 0) {
							Text(selectedX, style: .time)
						}
					}
			}
		}.chartXAxis(content: {
			AxisMarks(
				position: .bottom, values: data.compactMap(\.date)
			){ value in
				if let date = value.as(Date.self) {
					AxisGridLine(stroke: .init(lineWidth: 1))
					if data.compactMap(\.date).evenIndexed().contains(date) && data.compactMap(\.date).last != date {
						AxisValueLabel {
							VStack(alignment: .center) {
								Text(date, format: .dateTime.hour().minute())
									.font(.footnote)
									.opacity( date < Date() ? 0.5 : 1.0)
							}
						}
					}
				}
			}
		})
		.chartYAxis(content: {
			AxisMarks(
				position: .trailing, values: Array(stride(from: 0,
														  to: min(100, (data.map(\.humidity).max() ?? 0) + 10),
														  by: 10)
				) ){ value in
					
					if let number = value.as(Int.self) {
						if [20, 50].contains(number) {
							AxisGridLine(stroke: .init(lineWidth: 2))
								.foregroundStyle(Color.colorForIndex(number))
							AxisValueLabel {
								VStack(alignment: .leading) {
									Text("\(number)")
										.fontWeight(.bold)
								}
								.foregroundStyle(Color.colorForIndex(number))
							}
							
						} else {
							AxisGridLine(stroke: .init(lineWidth: 1))
							AxisValueLabel {
								VStack(alignment: .leading) {
									Text("\(number)")
								}
							}
						}
					}
				}
		})
		.chartYScale(domain: 0...(min(100, (data.map(\.humidity).max() ?? 0)) + 10))
		.chartXSelection(value: $selectedX)
		.frame(height: 400)
		.padding()
	}
}

#Preview("轴线折线图") {
	let data: [HumidityRate] = HumidityRate.samples
	AxisTitleLineMarkView(data: data)
}

extension Array {
	func evenIndexed() -> Self {
		self.enumerated()
			.compactMap { index, element in
				index.isMultiple(of: 2) ? element : nil
			}
	}
}
