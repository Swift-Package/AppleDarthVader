//
//  ColorTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing
import UIKit

private enum Colors {
    @ColorWrapper(dark: .black, light: .red)
    static var mainRed
}

struct ColorTests {
    @Test func test() {
        #expect(Colors.mainRed == UIColor.red)

        // 不管设备外观如何都访问需要的确切的颜色
        #expect(Colors.$mainRed.isDark == false)
        #expect(Colors.$mainRed.light == UIColor.red)
        #expect(Colors.$mainRed.dark == UIColor.black)
    }
}
