//
//  TimerExtensionsTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/5.
//

@testable import AppleDarthVader
import Combine
import Testing
import UIKit

struct TimerExtensionsTests {
    private var observables: [AnyCancellable] = []

    @Test mutating func test() {
        let array: [ImagePublisher] = ["some", UIColor.white]
        Timer.loop(every: 4, over: array.count)
            .flatMap { array[$0].imagePublisher() }
            .assign(to: \.image, on: UIImageView())
            .store(in: &observables)
    }
}
