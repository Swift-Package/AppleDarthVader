//
//  CustomViewController.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/5.
//

import UIKit

class CustomViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self)
        print(String(describing: type(of: self)).appending(" deinit"))
    }

    private var didSetupConstraints = false
    private var compactLayoutConstraints: [NSLayoutConstraint] = []
    private var iPadPortraitLayoutConstraints: [NSLayoutConstraint] = []
    private var iPadLandscapeLayoutConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayoutConstraints()
        initialize()
    }

    // MARK: - 业务逻辑初始化

    private func initialize() {}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 状态回复逻辑 - 保存自定义用户活动
        // view.window?.windowScene?.userActivit =

        // let cccc = KeychainViewController.init()
        // present(cccc, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 状态恢复逻辑 - 去除用户活动状态
        view.window?.windowScene?.userActivity = nil
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // 当视图控制器需要知道它已被添加到容器中时它可以重写此方法
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
    }
}

extension CustomViewController {
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
}

// MARK: - 键盘快捷键支持逻辑

extension CustomViewController {
    override var keyCommands: [UIKeyCommand]? {
        return nil // [UIKeyCommand(title: "New Note", action: #selector(openNewNote), input: "n", modifierFlags: .command)]
    }

    // MARK: 是否响应键盘快捷方式拦截

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return super.canPerformAction(action, withSender: sender)
//        if action == #selector(dismiss) {
//            return splitViewController == nil
//        } else if action == #selector(saveNote) {
//            return viewType == .create
//        } else {
//            return super.canPerformAction(action, withSender: sender)
//        }
    }
}

// MARK: - 纯布局约束

extension CustomViewController {
    private func buildLayoutConstraints() {
        // MARK: - 触发约束更新

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        let isPortrait = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first!.interfaceOrientation.isPortrait

        if !didSetupConstraints {
            didSetupConstraints = true
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            if isPortrait {
                NSLayoutConstraint.deactivate(iPadLandscapeLayoutConstraints)
                NSLayoutConstraint.deactivate(compactLayoutConstraints)
                NSLayoutConstraint.activate(iPadPortraitLayoutConstraints)
            } else {
                NSLayoutConstraint.deactivate(compactLayoutConstraints)
                NSLayoutConstraint.deactivate(iPadPortraitLayoutConstraints)
                NSLayoutConstraint.activate(iPadLandscapeLayoutConstraints)
            }
        } else {
            NSLayoutConstraint.deactivate(iPadLandscapeLayoutConstraints)
            NSLayoutConstraint.deactivate(iPadPortraitLayoutConstraints)
            NSLayoutConstraint.activate(compactLayoutConstraints)
        }

        super.updateViewConstraints()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // MARK: 重新布局

        view.setNeedsUpdateConstraints()
    }
}
