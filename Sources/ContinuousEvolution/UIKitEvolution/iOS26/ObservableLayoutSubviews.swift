//
//  ObservableLayoutSubviews.swift
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
            self.navigationController?.pushViewController(MViewController(unreadMessagesModel: UnreadMessagesModel.init(showStatus: true, statusText: "aaaa"), statusLabel: .init()), animated: true)
        }
    }
}

// MARK: - 1.使用viewWillLayoutSubviews绑定 Observable 视图模型
@Observable
fileprivate class UnreadMessagesModel {
    
    var showStatus: Bool
    var statusText: String
    
    init(showStatus: Bool, statusText: String) {
        self.showStatus = showStatus
        self.statusText = statusText
    }
}

@available(iOS 26.0, *)
fileprivate class MViewController: UIViewController {
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var statusLabel: UILabel
    
    var unreadMessagesModel: UnreadMessagesModel
    
    // MARK: - 初始化方法
    init(unreadMessagesModel: UnreadMessagesModel, statusLabel: UILabel) {
        self.statusLabel = statusLabel
        self.unreadMessagesModel = unreadMessagesModel
        print("1.创建MViewController")
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2.viewDidLoad")
        buildLayoutConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("5.viewWillLayoutSubviews")
        statusLabel.alpha = unreadMessagesModel.showStatus ? 1.0 : 0.0
        statusLabel.text = unreadMessagesModel.statusText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("6.viewDidAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            print("7.更新属性")
            unreadMessagesModel.showStatus = true
            unreadMessagesModel.statusText = "xxxx"
            // MARK: - ⚠️UIKit在showStatus和statusText记录了依赖项
            // MARK: - 对模型的属性的更新将触发视图无效并重新调用viewWillLayoutSubviews
        }
    }
}

// MARK: - 纯布局约束
@available(iOS 26.0, *)
fileprivate extension MViewController {
    private func buildLayoutConstraints() {
        print("3.buildLayoutConstraints")
        view.addSubview(statusLabel)
        statusLabel.textColor = .red
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // MARK: - 触发约束更新
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        print("4.updateViewConstraints")
        super.updateViewConstraints()
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
