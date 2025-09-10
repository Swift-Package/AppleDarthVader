//
//  GestureNavigation.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/22.
//

import SwiftUI
import UIKit

// MARK: - 解决自定义返回按钮导致侧滑返回手势失效的问题

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
