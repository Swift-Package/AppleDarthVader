//
//  DefaultMainActorViewFour.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/19.
//

import SwiftUI

struct DefaultMainActorViewFour: View {
    var body: some View {
        Text("Hello, world!")
        .padding()
        .onAppear {
            // DefaultMainActorFour.run()
        }
    }
}

#Preview {
    DefaultMainActorViewFour()
}

fileprivate struct DefaultMainActorFour {
    
    // MARK: - 在 MainActor 上下文调用 run
    static func run() {
        Task { @MainActor in
            // 检测是否处于 MainActor 否则崩溃
            MainActor.assertIsolated()
            
            let example = DefaultMainActorFour()
            await example.concurrencyAndAsync()
        }
    }
    
    @concurrent
    func concurrencyAndAsync() async {
        MainActor.assertIsolated()// ⚠️在这里崩溃,因为 @concurrent 标记的函数不会在 MainActor 上执行
        print(1)
    }
}
