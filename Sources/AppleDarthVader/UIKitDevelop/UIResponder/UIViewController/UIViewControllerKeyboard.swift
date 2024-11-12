//
//  UIViewControllerKeyboard.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

@objc
public extension UIViewController {
    /// 关闭键盘
    func closeKeyboard() {
        for view in view.subviews where view.isFirstResponder {
            view.resignFirstResponder()
        }
    }
}
