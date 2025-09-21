//
//  EnvironmentEntryMacro.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/2.
//

// Youtube - Vincent Pradeilles - Don't write this code!(use the @Entry macro instead)

import SwiftUI

public extension EnvironmentValues {
    @Entry var customColor: Color = .white
}

// MARK: - 代替下面复杂的写法
//private struct CustomColorEnvironmentKey: @MainActor EnvironmentKey {
//    static var defaultValue: Color = .white
//}
//
//private extension EnvironmentValues {
//    var customColorX: Color {
//        get {
//            self[CustomColorEnvironmentKey.self]
//        }
//        set {
//            self[CustomColorEnvironmentKey.self] = newValue
//        }
//    }
//}
