//
//  UIApplicationTool.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

@objc
public extension UIApplication {
    /// 清除启动页缓存
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
            print("AppleDarthVader 清除启动页缓存成功")
        } catch {
            print("AppleDarthVader 清除启动页缓存失败")
        }
    }
}
