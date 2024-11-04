//
//  UserDefaultsSuite.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://www.swiftbysundell.com/articles/the-power-of-userdefaults-in-swift/

import Foundation

public extension UserDefaults {
    static var skywalker: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.skywalker.package")
        return combined
    }
}
