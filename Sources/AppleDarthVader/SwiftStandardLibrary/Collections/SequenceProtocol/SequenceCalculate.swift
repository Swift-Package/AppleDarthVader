//
//  SequenceCalculate.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// Coordinator协调器作者在2017年的技术演讲
// https://www.youtube.com/watch?v=3ia3ngqM2mM

import Foundation

public extension Sequence where Self.Iterator.Element: SignedInteger {
    var sum: Self.Iterator.Element { reduce(0, +) }
}

public extension Sequence where Self.Iterator.Element: BinaryFloatingPoint {
    var sum: Self.Iterator.Element { reduce(0, +) }
}
