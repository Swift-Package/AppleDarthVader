//
//  ViewExtract.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/2.
//

// Youtube - Kavsoft - Extract UIKit View From SwiftUI View

import SwiftUI

struct ViewExtractView: View {
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "heart.fill") {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                        .viewExtract { view in
                            print("这种View是SwiftUI原生的View不包含任何UIKit View") // 该行代码不会执行
                        }
                    
                    Slider(value: .constant(2))
                        .viewExtract { view in
                            if let slider = view as? UISlider {
                                slider.tintColor = .red
                            }
                        }
                    
                    TextField("Hello World", text: .constant(""))
                        .viewExtract { _ in
                            print("TextField 以及 Slider是使用SwiftUI包装器包装UIKit的")
                        }
                    
                    List {
                        Text("Hello World")
                    }
                    .viewExtract { view in
                        if view is UICollectionView {
                            print("SwiftUI 中的 List 是 UIKit 中的 UICollectionView")
                        }
                    }
                }
                .padding()
            }
        }
        .viewExtract { view in
            if let tabViewController = view.next as? UITabBarController {
                tabViewController.tabBar.isHidden = false
                tabViewController.tabBar.tintColor = .red
            }
        }
    }
}

#Preview {
    ViewExtractView()
}

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
