//
//  SequenceConditionMatch.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// Coordinator协调器作者在2017年的技术演讲
// https://www.youtube.com/watch?v=3ia3ngqM2mM

import Foundation

public extension Sequence {
    func uniqueElements(by elementsEqual: (Iterator.Element, Iterator.Element) -> Bool) -> [Iterator.Element] {
        var result: [Iterator.Element] = []

        for element in self {
            if !result.contains(where: { resultElement in elementsEqual(element, resultElement) }) {
                result.append(element)
            }
        }
        return result
    }
}

public extension Sequence where Iterator.Element: Equatable {
    func uniqueElements() -> [Iterator.Element] { uniqueElements(by: ==) }
}
