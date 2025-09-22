//
//  UpdateProperties.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/23.
//

// WWDC 26 - UIKit 的新功能

import UIKit
import SwiftUI
import Observation

@available(iOS 26.0, *)
fileprivate class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self else { return }
            self.navigationController?.pushViewController(MyViewController(model: BadgeModel.init(), folderButton: .init(title: nil, image: .init(systemName: "folder"), target: nil, action: nil)), animated: true)
        }
    }
}

// MARK: - 2.关于 updateProperties 相关
@Observable
fileprivate class BadgeModel {
    var badgeCount: Int?
    var color = UIColor.red
}

@available(iOS 26.0, *)
fileprivate class MyViewController: UIViewController {
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var model: BadgeModel
    let folderButton: UIBarButtonItem
    
    init(model: BadgeModel, folderButton: UIBarButtonItem) {
        self.model = model
        self.folderButton = folderButton
        print("1.创建MyViewController")
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2.viewDidLoad")
        navigationItem.rightBarButtonItem = folderButton// 这里就会触发一次 updateProperties
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3.viewDidAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            print("4.更新可观察属性")
            
            // 使用 .flushUpdate 更新可观察对象的动画无需调用动画关联视图的 layoutIfNeed
            UIView.animate(withDuration: 5, delay: 0, options: .flushUpdates) {
                self.model.badgeCount = 4
                self.model.color = .green
            }
            
            // iOS 18 和之前需要调用 关联视图.setNeedsLayout() 来执行更新并创建动画
            UIView.animate(withDuration: 5, delay: 0) {
                // self.model.color = .green
                // 关联视图.setNeedsLayout()
            }
        }
    }
    
    // MARK: - 下面这个方法在 UIView 和 UIViewController 均有,重写这个方法进行自定义并且这个方法在 layoutSubviews 之前运行但是两个是独立的让你能够使属性无效而无需强制进行布局 还有就是这个方法可以通过 setNeedsUpdateProperties 手动触发
    override func updateProperties() {
        super.updateProperties()
        print("updateProperties")
        folderButton.tintColor = model.color
        if let badgeCount = model.badgeCount {
            folderButton.badge = .count(badgeCount)
        } else {
            folderButton.badge = nil
        }
    }
}

// MARK: - 需要部署到 iOS 18 需要开启 UIObservationTrackingEnabled: YES
#Preview {
    Button("点击查看效果") {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            if #available(iOS 26.0, *) {
                window.rootViewController = UINavigationController(rootViewController: ViewController())
            } else {
                // Fallback on earlier versions
            }
            window.makeKeyAndVisible()
        }
    }
}
