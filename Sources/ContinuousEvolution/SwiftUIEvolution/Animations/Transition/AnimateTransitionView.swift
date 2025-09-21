//
//  AnimateTransitionView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/21.
//

// Pragma Conference 2024 - SwiftUI Animations Under The Hood - Chris Eidhof

import SwiftUI

// MARK: - 定制动画过渡效果
struct AnimateTransitionView: View {
    
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Capsule()
                .fill(.blue)
                .frame(width: 200, height: 100)
            if isOn {
                Rectangle()
                    .fill(.green)
                    .frame(width: 200, height: 100)
                    .transition(.scale.combined(with: .opacity))// 定制动画过渡效果
            }
        }
        .animation(.easeInOut, value: isOn)
        .onTapGesture {
            isOn.toggle()
        }
    }
}

#Preview("动画过渡效果") {
    AnimateTransitionView()
}

// MARK: - 视图修饰符携带状态
struct ShakeModifier: ViewModifier {
    
    var numberOfTaps: CGFloat
    
    func body(content: Content) -> some View {
        let _ = print(numberOfTaps)
        content
            .offset(x: numberOfTaps * 10)
    }
}

fileprivate struct ContentView: View {
    
    @State private var numberOfTaps = 0
    
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 100, height: 100)
            .animation(.easeInOut, value: numberOfTaps)
            .modifier(ShakeModifier(numberOfTaps: CGFloat(numberOfTaps)))
            .onTapGesture {
                numberOfTaps += 1
            }
    }
}

#Preview("视图修饰符携带状态") {
    ContentView()
}

// MARK: - 符合可动画协议的视图修饰符
struct ShakeModifier1: ViewModifier, @MainActor Animatable {
    
    var numberOfTaps: CGFloat
    
    // MARK: - 目前演讲没有提到这一部分
    var animatableData: CGFloat {
        get { numberOfTaps }
        set { numberOfTaps = newValue }
    }
    
    func body(content: Content) -> some View {
        let _ = print(numberOfTaps)
        content
            .offset(x: numberOfTaps * 10)
    }
}

fileprivate struct ContentView1: View {
    
    @State private var numberOfTaps = 0
    
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 100, height: 100)
            .animation(.easeInOut, value: numberOfTaps)
            .modifier(ShakeModifier1(numberOfTaps: CGFloat(numberOfTaps)))
            .onTapGesture {
                numberOfTaps += 1
            }
    }
}

#Preview("符合可动画协议视图修饰符") {
    ContentView1()
}
