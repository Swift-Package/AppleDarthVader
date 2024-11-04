//
//  ImageAssetTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing
import UIKit

private enum Asset {
    @ImageAsset(key: "DarthVader")
    public static var darthVaderIcon: UIImage
}

struct ImageAssetTests {
    @Test func test() {
        let image = UIImage(named: "DarthVader", in: Bundle.module, with: nil)
        #expect(image != nil)
        #expect(Asset.darthVaderIcon != nil)
    }
}
