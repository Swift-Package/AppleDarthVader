//
//  OptionalExtesions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/13.
//

import Foundation

// MARK: - 扩展可选类型便利解包- 20251112 神牛公司面试题
public extension Optional {
	func unwrapped(or defaultValue: Wrapped) -> Wrapped {
		self ?? defaultValue
	}
}
