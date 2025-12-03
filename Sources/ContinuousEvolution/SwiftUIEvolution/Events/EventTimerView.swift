//
//  EventTimerView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

import SwiftUI

fileprivate struct EventTimerView: View {
	
	@State var count = 0
	@State var animateButton = true
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	var body: some View {
		let _ = Self._logChanges()
		VStack {
			Text("Count is now: \(count)")
				.onReceive(timer) { input in
					count += 1
				}
			Button {
				
			} label: {
				Text("SAVE")
					.foregroundColor(.white)
					.font(.system(size: 36, weight: .bold, design: .rounded))
					.padding(.vertical, 6)
					.padding(.horizontal, 80)
					.background(.red)
					.cornerRadius(50)
					.shadow(color: .secondary, radius: 1, x: 0, y: 5)
			}.rotationEffect(Angle(degrees: animateButton ? Double.random(in: -8.0...1.5) : Double.random(in: 0.5...16)))
			// 旋转效果的随机值会在每次视图重绘时改变。计时器和布尔切换会触发重绘导致按钮出现跳动而不是平滑的动画效果
			
			AnimatedButton()// 独立管理实现平滑动画
		}.onAppear {
			withAnimation(.easeInOut(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
				animateButton.toggle()
			}
		}
	}
}

fileprivate struct AnimatedButton: View {
	
	@State private var animateButton = true
	
	var body: some View {
		Button {
			
		} label: {
			Text("SAVE")
				.font(.system(size: 36, weight: .bold, design: .rounded))
				.foregroundColor(.white)
				.padding(.vertical, 6)
				.padding(.horizontal, 80)
				.background(.red)
				.cornerRadius(50)
				.shadow(color: .secondary, radius: 1, x: 0, y: 5)
		}.rotationEffect(Angle(degrees: animateButton ? Double.random(in: -8.0...1.5) : Double.random(in: 0.5...16))).onAppear {
			withAnimation(.easeInOut(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
				animateButton.toggle()
			}
		}
	}
}

#Preview {
	EventTimerView()
}
