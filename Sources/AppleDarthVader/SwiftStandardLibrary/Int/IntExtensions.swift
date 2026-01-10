//
//  IntExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Int {
	
    /// 是否偶数
    var isEven: Bool { isMultiple(of: 2) }
	
	/// 罗马数字字符串表示
	var romanNumeral: String {
		RomanNumeralConverter().convert(self)
	}
	
	// MARK: - 检查底层数据的第 i 位是否为 1
	subscript(bit i: Int) -> Bool {
		get {
			// 1 左移 i 位得到检查码跟 self 进行与测试
			let bitMask = 1 << i
			return (self & bitMask) != 0
		}
	}
	
	subscript(safeBit i: Int) -> Bool {
		guard i >= 0 && i < Int.bitWidth else { return false }
		return (self & (1 << i)) != 0
	}
}
