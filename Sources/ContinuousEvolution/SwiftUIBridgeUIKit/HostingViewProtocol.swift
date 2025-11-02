//
//  HostingViewProtocol.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/3.
//

import UIKit
import SwiftUI

@MainActor public protocol HostingView {}

extension UIView: HostingView {}

public extension HostingView where Self == UIView {
 
    init(@ViewBuilder content: () -> some View) {
        let hostingController = UIHostingController(rootView: content())
        hostingController.sizingOptions = .intrinsicContentSize
        self = hostingController.view
        hostingController.view = nil
    }
}

public extension UIViewController {
    func addChildSwiftUIView(_ swiftUIView: some View, configurationHandler: (_ hostingView: UIView) -> Void) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.sizingOptions = .intrinsicContentSize
        addChild(hostingController)
        hostingController.view.backgroundColor = .clear
        configurationHandler(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
