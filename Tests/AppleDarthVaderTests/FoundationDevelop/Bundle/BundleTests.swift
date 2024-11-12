//
//  BundleTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// https://openweathermap.org/current#current_JSON

@testable import AppleDarthVader
import Foundation
import Testing

// MARK: - 天气服务API返回的数据模型

struct WeatherbitData: Decodable {
    private static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    enum CodingKeys: String, CodingKey {
        case observation = "data"
    }

    let observation: [Observation]

    struct Observation: Decodable {
        let temp: Double
        let datetime: String

        let weather: Weather

        struct Weather: Decodable {
            let icon: String
            let description: String
        }
    }

    var currentTemp: Double {
        observation[0].temp
    }

    var iconName: String {
        observation[0].weather.icon
    }

    var description: String {
        observation[0].weather.description
    }

    var date: Date {
        let dateString = String(observation[0].datetime.prefix(10))
        return Self.dateFormatter.date(from: dateString) ?? Date()
    }
}

struct BundleTests {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()

    var exampleJSONData: Data!
    var weather: WeatherbitData!

    init() {
        // let bundle = Bundle(for: type(of: self))
        let url = Bundle.module.url(forResource: "WeatherbitExample", withExtension: "json")! // 访问到当前测试目标内的WeatherbitExample.json文件
        exampleJSONData = try! Data(contentsOf: url)
        weather = try! JSONDecoder().decode(WeatherbitData.self, from: exampleJSONData)
    }

    @Test("仅仅用来测试使用Bundle.module访问当前模块资源文件进行解码的操作") func test() {
        #expect(weather.currentTemp == 24.19)
        #expect(weather.iconName == "c03d")
        #expect(weather.description == "Broken clouds")
        #expect(Self.dateFormatter.string(from: weather.date) == "08-28-2017")
    }
}
