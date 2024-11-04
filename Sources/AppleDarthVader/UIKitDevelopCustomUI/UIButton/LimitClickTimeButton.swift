//
//  LimitClickTimeButton.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

/// 点击5次后失效的按钮
class LimitClickTimeButton: UIButton {
    private(set) var amountOfTouches: Int = 0 {
        didSet {
            if amountOfTouches >= 5 {
                isEnabled = false
                isUserInteractionEnabled = false
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        amountOfTouches += 1
    }
}
