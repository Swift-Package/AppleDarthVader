//
//  SwiftUIView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/19.
//

// 教程来源 - https://www.youtube.com/watch?v=UraPKevc8MI&t=184s

import SwiftUI

// MARK: - 启动屏幕动画效果用法
fileprivate struct LaunchScreenApp: App {
    var body: some Scene {
        SplashLaunchScreen {
            Image(systemName: "playstation.logo")
        } rootContent: {
            ContentView()
        }
    }
}

// MARK: - 启动动画配置
public struct LaunchScreenConfig {
    var forceHideLogo = true   // 徽标将缩放到指定值并移除启动画面否则会添加额外的淡出模糊效果
    var scaling: CGFloat = 4
    var initialDelay: Double = 0.5
    var backgroundColor: Color = .black
    var logoBackgroundColor: Color = .white
    var animation: Animation = .smooth(duration: 1, extraBounce: 0)// 动画效果
}

// MARK: - 启动动画
public struct SplashLaunchScreen<RootView: View, Logo: View>: Scene {
    
    var config: LaunchScreenConfig = .init()
    
    @ViewBuilder var logo: () -> Logo
    @ViewBuilder var rootContent: RootView
    
    public var body: some Scene {
        WindowGroup {
            rootContent
                .modifier(LaunchScreenModifier(config: config, logo: logo))
        }
    }
}

fileprivate struct LaunchScreenModifier<Logo: View>: ViewModifier {
    
    var config: LaunchScreenConfig
    
    @ViewBuilder var logo: Logo
    
    @Environment(\.scenePhase)
    private var scenePhase
    @State private var splashWindow: UIWindow?
    
    func body(content: Content) -> some View {
        // 添加一个顶层的 window 让 Splash Screen 处于整个应用的最顶层
        content
            .onAppear {
                let scenes = UIApplication.shared.connectedScenes
                for scene in scenes {
                    guard let windowScene = scene as? UIWindowScene,
                          checkStates(windowScene.activationState),
                            // 检查 windowScene 已经有 Splash Window 以支持 iPadOS 的多窗口启动
                            !windowScene.windows.contains(where: { $0.tag == 1009 })
                    else {
                        print("已经存在一个 Splash Window")
                        continue
                    }
                    
                    let window = UIWindow(windowScene: windowScene)
                    window.tag = 1009
                    window.isHidden = false
                    window.backgroundColor = .clear
                    window.isUserInteractionEnabled = true
                    let rootViewController = UIHostingController(rootView: LaunchScreenView(config: config, isCompleted: {
                        window.isHidden = true
                        window.isUserInteractionEnabled = false
                    }, logo: {
                        logo
                    }))
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
                    self.splashWindow = window
                    print("添加 Splash Window")
                }
            }
    }
    
    // MARK: - 检查 ScenePhase 和 WindowScene 状态是否相同
    private func checkStates(_ state: UIWindowScene.ActivationState) -> Bool {
        switch scenePhase {
        case .background:
            return state == .background
        case .inactive:
            return state == .foregroundInactive
        case .active:
            return state == .foregroundActive
        default:
            return state.hashValue == scenePhase.hashValue
        }
    }
}

fileprivate struct LaunchScreenView<Logo: View>: View {
    
    var config: LaunchScreenConfig
    var isCompleted: () -> ()
    
    @ViewBuilder var logo: Logo
    
    @State private var scaleDown = false
    @State private var scaleUp = false
    
    var body: some View {
        Rectangle()
            .fill(config.backgroundColor)
            .mask {
                GeometryReader { proxy in
                    let size = proxy.size.applying(.init(scaleX: config.scaling, y: config.scaling))
                    Rectangle()
                        .overlay {
                            logo
                                .blur(radius: config.forceHideLogo ? 0 : (scaleUp ? 15 : 0))
                                .blendMode(.destinationOut)
                                .animation(.smooth(duration: 0.3, extraBounce: 0)) { content in
                                    content
                                        .scaleEffect(scaleDown ? 0.8 : 1)
                                }
                                .visualEffect { [scaleUp] content, proxy in
                                    let scaleX: CGFloat = size.width / proxy.size.width
                                    let scaleY: CGFloat = size.height / proxy.size.height
                                    let maxScale = Swift.max(scaleX, scaleY)
                                    return content
                                        .scaleEffect(scaleUp ? maxScale : 1)
                                }
                        }
                }
            }
            .opacity(config.forceHideLogo ? 1 : (scaleUp ? 0 : 1))
            .background {
                Rectangle()
                    .fill(config.logoBackgroundColor)
                    .opacity(scaleUp ? 0 : 1)
            }
            .ignoresSafeArea()
            .task {
                guard !scaleDown else { return }
                try? await Task.sleep(for: .seconds(config.initialDelay))
                scaleDown = true
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(config.animation, completionCriteria: .logicallyComplete) {
                    scaleUp = true
                } completion: {
                    isCompleted()
                }
            }
    }
}
