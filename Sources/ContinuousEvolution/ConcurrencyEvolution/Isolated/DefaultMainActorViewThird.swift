//
//  DefaultMainActorViewThird.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/19.
//

import SwiftUI

// MARK: - 这个视图需要在真实项目中取消 Examples.run() 注释运行无法在 Package 中预览
fileprivate struct DefaultMainActorViewThird: View {
    var body: some View {
        Text("Hello, world!")
        .padding()
        .onAppear {
            // DefaultMainActorThird.run()
        }
    }
}

#Preview {
    DefaultMainActorViewThird()
}

// MARK: - 不使用默认 MainActor 隔离
nonisolated
struct DefaultMainActorThird {
    
    // MARK: - 在 MainActor 上下文调用 run
    static func run() {
        // 然后从 MainActor 上下文隔离出去
        Task.detached {
            let example = DefaultMainActorThird()
            
            await example.isolatedAndSync()
            await example.isolatedAndAsync()
            example.nonisolatedAndSync()
            await example.nonisolatedAndAsync()
        }
    }
    
    // MARK: - 隔离到 MainActor 上下文同步执行
    @MainActor
    func isolatedAndSync() {
        MainActor.assertIsolated()
        print(1)
    }
    
    // MARK: - 隔离到 MainActor 上下文异步执行
    @MainActor
    func isolatedAndAsync() async {
        MainActor.assertIsolated()
        // 可以挂起后续再回到 MainActor 执行
        print(2)
    }
    
    // MARK: - 不隔离在调用者的默认上下文中执行
    func nonisolatedAndSync() {
        MainActor.assertIsolated()// ⚠️将这里崩溃,因为 MainActor 断言失败
        print(3)
    }
    
    // MARK: - 不隔离在调用者的默认上下文中异步执行
    func nonisolatedAndAsync() async {
        MainActor.assertIsolated()
        print(4)
    }
}
