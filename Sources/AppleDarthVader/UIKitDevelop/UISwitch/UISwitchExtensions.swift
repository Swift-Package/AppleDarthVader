//
//  UISwitchExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

@objc
public extension UISwitch {
    /// 切换开关状态
    /// - Parameter animated: 是否需要切换动画
    func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}
