//
//  ThreadExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/7/18.
//

import Foundation

nonisolated extension Thread {
    
    /// 一个用于在异步方法中打印当前线程的便捷方法
    /// 详情请见：https://github.com/swiftlang/swift-corelibs-foundation/issues/5139
    public static var currentThread: Thread {
        Thread.current
    }
}
