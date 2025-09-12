//
//  MainActorSafe.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// 王巍博客 - Swift 6 适配的一些体会以及对现状的小吐槽 - https://onevcat.com/2024/07/swift-6/
// Global Actors in Swift (2022) – iOS - https://www.youtube.com/watch?v=CU_FfeTuQXs

import Foundation

public extension MainActor {
    static func runSafely<T>(_ block: @MainActor () -> T) throws -> T {
        if Thread.isMainThread {
            return MainActor.assumeIsolated { block() }
        } else {
            MainActor.assertIsolated("This method is expected to be called in main thread!")
            return DispatchQueue.main.sync {
                MainActor.assumeIsolated { block() }
            }
        }
    }
    
    // MARK: - 这个方法 MainActor.run Apple 已经有了
    static func run<T>(resultType: T.Type = T.self, block: @MainActor @Sendable () throws -> T) async rethrows -> T {
        do {
            return try await block()
        } catch {
            throw error
        }
    }
}
