//
//  ButtonStyleExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import SwiftUI

// MARK: - 自定义按钮样式
public struct CustomButtonStyle: ButtonStyle {
    
    var backgroundColor: Color
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .foregroundStyle(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 10)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - 自定义按钮样式与显性动画和隐性动画
struct CustomButtonStyleContentView: View {
    
    @State var isStarted = false
    @State var isPaused = false
    
    var body: some View {
        VStack {
            if isPaused {
                HStack {
                    Button("停止") {
                        isStarted = false
                        isPaused = false
                    }
                    .buttonStyle(CustomButtonStyle(backgroundColor: .red))
                    Button("继续") {
                        isPaused = false
                    }
                    .buttonStyle(CustomButtonStyle(backgroundColor: .green))
                }
            } else {
                Button(isStarted ? "暂停" : "开始") {
                    withAnimation(.easeIn(duration: 1)) {// 显性动画
                        if !isStarted {
                            isStarted = true
                        } else {
                            isPaused = true
                        }
                    }
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .blue))
                //.transition(.scale.combined(with: .slide))// 转场动画
                .transition(.asymmetric(insertion: .slide, removal: .scale))// 非对称转场动画
            }
        }
        //.animation(.easeInOut(duration: 3), value: isPaused)// 隐性动画
    }
}

#Preview {
    CustomButtonStyleContentView()
}
