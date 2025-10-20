//
//  ViewBuilderDestination.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/12.
//

// 教程来源 - https://www.youtube.com/watch?v=dlZyceMoDSc

import SwiftUI

// MARK: - 路由器
fileprivate final class Route: ObservableObject {
    
    @Published var navPaths = NavigationPath()
    @Published var stack: [Routes] = []
    
    enum Routes: Hashable {
        case first
        case second(message: String)
        case third
    }
    
    func nagvigate(to route: Routes) {
        navPaths.append(route)
        stack.append(route)
    }
    
    func pop() {
        navPaths.removeLast()
        stack.removeLast()
    }
    
    func navitateBackToRoot() {
        navPaths.removeLast(navPaths.count)
        stack.removeLast(navPaths.count)
    }
    
    // MARK: - 返回到指定页面
    func navigateBack(to target: Routes) {
        guard !stack.isEmpty else { return }
        
        while let last = stack.last, last != target {
            stack.removeLast()
            if !navPaths.isEmpty {
                navPaths.removeLast()
            }
        }
    }
}

extension Route {
    @MainActor @ViewBuilder
    func destinationView(for route: Routes) -> some View {
        switch route {
        case .first:
            ViewBuilderDestination()
        case .second(let message):
            SecondView(message: message)
        case .third:
            ThirdView()
        }
    }
}

// MARK: - 首页
fileprivate struct ViewBuilderDestination: View {
    
    @EnvironmentObject var router: Route
    
    @State var message: String = "Hello, World!"
    
    var body: some View {
        TextField("Enter", text: $message)
        Button("Go to Second View") {
            router.nagvigate(to: .second(message: message))
        }
    }
}

// MARK: - 第二页
fileprivate struct SecondView: View {
    
    @EnvironmentObject var router: Route
    
    let message: String
    
    var body: some View {
        Text(message)
        Button("Go to Third View") {
            router.nagvigate(to: .third)
        }
    }
}

// MARK: - 第三页
fileprivate struct ThirdView: View {
    
    @EnvironmentObject var router: Route
    
    var body: some View {
        Button("Pod") {
            router.pop()
        }
        
        Button("Back to Root View") {
            router.navitateBackToRoot()
        }
        
        Button("Back to First View") {
            print(router.stack.count)
            router.navigateBack(to: .second(message: "aaa"))// 这里会有Bug表现为直接回到首页 因为带参数的枚举类型无法直接比较
        }
    }
}

#Preview {
    @Previewable @ObservedObject var router = Route()
    
    NavigationStack(path: $router.navPaths) {
        ViewBuilderDestination()
            .navigationDestination(for: Route.Routes.self) { destination in
                router.destinationView(for: destination)
            }
    }
    .environmentObject(router)
}
