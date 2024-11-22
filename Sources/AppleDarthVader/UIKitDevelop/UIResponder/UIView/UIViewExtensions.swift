//
//  UIViewExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

@objc
public extension UIView {
    /// 添加一系列子视图便捷书写方法view.add(subviews: firstView, secondView)
    /// - Parameter subviews: 子视图
    @nonobjc func add(subviews: UIView...) {
        for subView in subviews {
            addSubview(subView)
        }
    }
    
    func loopViewHierarchy(block: (_ view: UIView, _ stop: inout Bool) -> ()) {
        var stop = false
        block(self, &stop)
        if !stop {
            subviews.forEach { $0.loopViewHierarchy(block: block) }
        }
    }
}
