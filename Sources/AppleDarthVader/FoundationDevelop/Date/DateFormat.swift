//
//  DateFormat.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

public extension Date {
    var displayFormat: String {
        formatted(.dateTime
            .year(.defaultDigits)
            .month(.wide)
            .day(.twoDigits)
            .hour(.conversationalDefaultDigits(amPM: .wide))
            .minute()
        )
    }

    /// 一般情况下服务器接受的JSON形式
    var json: String {
        formatted(.iso8601)
    }
}
