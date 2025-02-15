//
//  ViewExtract.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/2.
//

// Youtube - Kavsoft - Extract UIKit View From SwiftUI View

import SwiftUI

public extension View {
    @ViewBuilder
    func viewExtract(result: @escaping (UIView) -> Void) -> some View {
        background(ViewExtractHelper(result: result))
            .compositingGroup()
    }
}

private struct ViewExtractHelper: UIViewRepresentable {
    var result: (UIView) -> Void

    func makeUIView(context _: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false

        DispatchQueue.main.async {
            if let uiKitView = view.superview?.superview?.subviews.last?.subviews.first {
                result(uiKitView)
            }
        }

        return view
    }

    func updateUIView(_: UIView, context _: Context) {}
}
