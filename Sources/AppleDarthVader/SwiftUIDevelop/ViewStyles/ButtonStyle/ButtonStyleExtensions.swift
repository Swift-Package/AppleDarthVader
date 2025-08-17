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
public struct CustomButtonStyleContentView: View {
    
    @State var isStarted = false
    @State var isPaused = false
    
    public init(isStarted: Bool = false, isPaused: Bool = false) {
        self.isStarted = isStarted
        self.isPaused = isPaused
    }
    
    public var body: some View {
        VStack {
            if isPaused {
                HStack {
                    Button(action: {
                        isStarted = false
                        isPaused = false
                    }, label: {
                        Text("Stop", bundle: .module)
                    })
                    .buttonStyle(CustomButtonStyle(backgroundColor: .red))
                    Button(action: {
                        isPaused = false
                    }, label: {
                        Text("Continue", bundle: .module)
                    })
                    .buttonStyle(CustomButtonStyle(backgroundColor: .green))
                }
            } else {
                Button(action: {
                    withAnimation(.easeIn(duration: 1)) {// 显性动画
                        if !isStarted {
                            isStarted = true
                        } else {
                            isPaused = true
                        }
                    }
                }, label: {
                    isStarted ? Text("Pause", bundle: .module) : Text("Start", bundle: .module)
                })
                
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
        .environment(\.locale, .init(identifier: "zh-Hans"))
}
