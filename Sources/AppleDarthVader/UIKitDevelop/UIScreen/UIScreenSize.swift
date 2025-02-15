//
//  UIScreenSize.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/2/15.
//

import UIKit

@objc
public extension UIScreen {
    static var screenSize: CGSize {
        let windowScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first
        return windowScene?.screen.bounds.size ?? .zero
    }
}
