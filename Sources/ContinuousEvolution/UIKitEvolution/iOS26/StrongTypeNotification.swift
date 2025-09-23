//
//  StrongTypeNotification.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/23.
//

// WWDC 26 - UIKit 的新功能

import UIKit
import SwiftUI

fileprivate class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .black
		
		// MARK: - 通知携带的信息现在可以强类型访问
		if #available(iOS 26.0, *) {
			_ = NotificationCenter.default.addObserver(of: UIScreen.self, for: .keyboardWillShow) { message in
				UIView.animate(withDuration: message.animationDuration, delay: 0) {
					let keyboardOverlap = self.view.bounds.maxY - message.endFrame.minY
					print(keyboardOverlap)
					// bottomConstraint.constant = keyboardOverlap
				}
			}
		}
	}
}

#Preview {
	Button("点击查看效果") {
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
			window.rootViewController = UINavigationController(rootViewController: ViewController())
		}
	}
}
