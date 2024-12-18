//
//  UserDefaultsExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation

enum UserDefaultsHelper {
    private static let defaults = UserDefaults(suiteName: XCConfiguration.stringValue(forKey: "USER_DEFAULTS_SUITE_NAME")) ?? .standard

    // 分离各个环境的数据
    private static let recordsKey = XCConfiguration.stringValue(forKey: "USER_DEFAULTS_RECORDS_KEY")

    static func getRecords() -> [Hatchling] {
        guard let objects = defaults.value(forKey: recordsKey) as? Data,
              let hatchlings = try? JSONDecoder().decode([Hatchling].self, from: objects)
        else { return [] }

        return hatchlings
    }

    static func persistRecords(_ array: [Hatchling]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            defaults.set(encoded, forKey: recordsKey)
        }
    }

    static func clearRecords() {
        defaults.removeObject(forKey: recordsKey)
    }

    static func getRecordsCount() -> Int {
        return getRecords().count
    }
}

struct Hatchling: Codable {
    var id = UUID()
    var tag: String
    var date: Date

    static func generatePreviewHatchlings() -> [Hatchling] {
        let leo = Hatchling(tag: "Leonardo", date: Date())
        let don = Hatchling(tag: "Donatello", date: Date())
        return [leo, don]
    }
}
