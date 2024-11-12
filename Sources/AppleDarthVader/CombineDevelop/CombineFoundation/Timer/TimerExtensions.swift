//
//  TimerExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Combine
import UIKit

public extension Timer {
    static func loop(every interval: TimeInterval, over total: Int) -> AnyPublisher<Int, Never> {
        if total < 1 { return Empty().eraseToAnyPublisher() }
        return publish(every: interval, on: .main, in: .common).autoconnect()
            .scan(0) { accumulator, _ in
                (accumulator + 1) % total
            }
            .prepend(0)
            .eraseToAnyPublisher()
    }
}
