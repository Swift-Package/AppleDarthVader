//
//  UIResponderRespondChain.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

extension UIResponder {
    private enum Static {
        weak static var responder: UIResponder?
    }

    /// 获取应用程序当前第一响应者
    /// - Returns: 应用程序当前第一响应者
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(_trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
