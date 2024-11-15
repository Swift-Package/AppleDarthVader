//
//  ColorHex.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import SwiftUI

public extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 08) & 0xFF) / 255,
                  blue: Double((hex >> 00) & 0xFF) / 255,
                  opacity: alpha)
    }
}
