//
//  OptionalExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// On Progressive Disclosure in Swift - Doug Gregor - Swift Craft 2025
// https://www.youtube.com/watch?v=opqKGgJavkw

import Foundation

public extension Optional where Wrapped == String {}

// MARK: - 扩展可选类型便利解包- 20251112 神牛公司面试题
public extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        self ?? defaultValue
    }
}

public extension Optional {
	func map<E: Error, U>(_ transfrom: (Wrapped) throws(E) -> U) throws(E) -> U? {
		switch self {
		case let value?:
			 try transfrom(value)
		case nil:
			nil
		}
	}
}
