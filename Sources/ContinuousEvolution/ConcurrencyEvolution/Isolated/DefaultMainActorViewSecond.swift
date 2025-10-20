//
//  DefaultMainActorViewSecond.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/19.
//

import SwiftUI

// MARK: - 这个视图需要在真实项目中取消 Examples.run() 注释运行无法在 Package 中预览
struct DefaultMainActorViewSecond: View {
    var body: some View {
        Text("Hello, world!")
        .padding()
        .onAppear {
            // DefaultMainActorSecond.run()
            // MARK: - 结果就是正常打印 1 2 3 4
        }
    }
}

#Preview {
    DefaultMainActorViewSecond()
}

fileprivate struct DefaultMainActorSecond {
    
    // MARK: - 在 MainActor 上下文调用 run
    static func run() {
        // 然后从 MainActor 上下文隔离出去
        Task.detached {
            // 检测是否处于 MainActor 否则崩溃
            // MainActor.assertIsolated()// 这个注释掉, 因为 detached 后这行代码不会在 MainActor 执行会导致断言所以先注释掉
            let example = DefaultMainActorSecond()
            
            await example.isolatedAndSync()// 因为分离到别的 Actor 所以要 await 回到 MainActor
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
    
    // MARK: - 不隔离在调用者的默认上下文中执行(默认继承到 MainActor 中执行,断言通过)
    func nonisolatedAndSync() {
        MainActor.assertIsolated()
        print(3)
    }
    
    // MARK: - 不隔离在调用者的默认上下文中异步执行(默认继承到 MainActor 中执行,断言通过)
    func nonisolatedAndAsync() async {
        MainActor.assertIsolated()
        print(4)
    }
}

// MARK: - 因为 Xcode 26 起 默认使用 @MainActor 以及继承调用者上下文, 所以 nonisolatedAndSync 和 nonisolatedAndAsync 方法能正常执行不会触发断言
// Build Settings - Swift Compiler - Concurrency - nonisolated(nonsending) By Default
