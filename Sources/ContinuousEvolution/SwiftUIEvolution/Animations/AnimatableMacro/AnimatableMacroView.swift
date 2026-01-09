//
//  AnimatableMacroView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/8.
//

// SwiftUI 中引入的可动画宏 - https://swiftwithmajid.com/2025/07/08/introducing-animatable-macro-in-swiftui/
// SwiftUI 中可动画值的魔力 - https://swiftwithmajid.com/2020/06/17/the-magic-of-animatable-values-in-swiftui/

import SwiftUI

@Animatable
fileprivate struct IntegerView: View {
	
	var number: Float
	
	@AnimatableIgnored
	var ignoredValue: Float = 0.0
	
	var body: some View {
		Text(number.formatted(.number.precision(.fractionLength(0))))
	}
}

fileprivate struct AnimatableMacroView: View {
    
	@State private var number: Float = 0
	   
	var body: some View {
		IntegerView(number: number)
			.animation(.default.speed(0.5), value: number)
		
		Button("Animate") {
			number = 100
		}
	}
}

#Preview {
	AnimatableMacroView()
}
