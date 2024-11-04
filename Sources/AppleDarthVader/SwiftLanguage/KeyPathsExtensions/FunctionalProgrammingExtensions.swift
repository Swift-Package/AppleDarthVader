//
//  FunctionalProgrammingExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.youtube.com/watch?v=gsPOl26C6VQ

import Foundation

public func > <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] > rightHandSide }
}

public func < <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] < rightHandSide }
}

public func >= <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] >= rightHandSide }
}

public func <= <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] <= rightHandSide }
}

public func == <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] == rightHandSide }
}

public func != <Root, Value: Comparable>(_ leftHandSide: KeyPath<Root, Value>, _ rightHandSide: Value) -> (Root) -> Bool {
    return { $0[keyPath: leftHandSide] != rightHandSide }
}
