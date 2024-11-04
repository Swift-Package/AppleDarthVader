//
//  BundleDecodeTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
@testable import AppleDarthVaderOC
import Testing

struct Project: Codable {
    var number: Int
    var title: String
    var subtitle: String
    var topics: String

    var attributedTitle: NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)

        titleString.append(subtitleString)
        return titleString
    }
}

struct BundleDecodeTests {
    @Test func test() {
        // ⚠️执行该测试时需要将扩展的Bundle.main改成Bundle.module以访问Skywalker模块里的Projects.json文件
        // let projects = Bundle.decode([Project].self, from: "Projects.json")
        // #expect(projects.first?.title == "Storm Viewer")
    }
}
