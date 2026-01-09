//
//  ProgressRing.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/7.
//

import SwiftUI

// MARK: - 进度圆环
public struct ProgressRing: View {
	
	@Binding var progress: Double
	let color: Color
	let size: CGFloat = 50
	let lineWidth: CGFloat = 5
	
	@State private var animatedProgress: Double = 0
	
    public var body: some View {
		ZStack {
			Text(progress, format: .number.precision(.fractionLength(1)))// 只保留一位小数
				.bold()
				.font(.caption)
			Circle()
				.stroke(color.opacity(0.2), lineWidth: lineWidth)
			Circle()
				.trim(from: 0, to: animatedProgress)
				.stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
				.rotationEffect(.degrees(-90))
		}
		.frame(width: size, height: size)
		.onAppear {
			withAnimation(.linear(duration: 1)) {
				animatedProgress = progress
			}
		}
		.onChange(of: progress) { _, newValue in
			withAnimation(.linear(duration: 0.2)) {
				animatedProgress = newValue
			}
		}
    }
}

#Preview {
	@Previewable @State var progress: Double = 0.4
	HStack {
		ProgressRing(progress: $progress, color: .cyan)
		Button {
			progress += 0.1
		} label: {
			Text("Add")
		}
	}
}
