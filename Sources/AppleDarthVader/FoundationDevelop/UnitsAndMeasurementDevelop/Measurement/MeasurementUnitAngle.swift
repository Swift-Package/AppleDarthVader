//
//  MeasurementUnitAngle.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Measurement where UnitType == UnitAngle {
    /// 初始化
    /// - Parameter degrees: 角度
    init(degrees: Double) {
        self.init(value: degrees, unit: .degrees)
    }

    /// 转换成弧度
    /// - Returns: 弧度
    func toRadians() -> Double {
        // 弧度 = 角度 * pi / 180
        return converted(to: .radians).value
    }
}
