//
//  MathUnitConverter.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

/// 数学单位转换工具
public enum MathUnitConverter {
    /// 将度数转换成弧度
    /// - Parameter degress: 度数
    /// - Returns: 弧度
    public static func degreeToRadians(_ degress: CGFloat) -> CGFloat {
        CGFloat.pi * degress / 180.0
    }
}
