//
//  SwiftUIViewBindingWrapper.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/2.
//

// 教程来源 - https://www.youtube.com/watch?v=vUe6uQae5PE

import UIKit
import Combine
import SwiftUI

// MARK: - 需要在 UIKit 中使用 SwiftUI 视图
fileprivate struct RedText: View {
    
    @Binding var isRed: Bool
    
    var body: some View {
        VStack {
            Text("Special Text")
                .foregroundColor(isRed ? .red : .black)
            Button("Toggle Color") {
                isRed.toggle()
            }
        }
    }
}

// MARK: - Binding 包装器
public extension BindingWrapper {
    class ViewModel: ObservableObject {
        
        @Published public var boundProperty: Value
        
        init(initialValue: Value) {
            self.boundProperty = initialValue
        }
    }
}

// MARK: - Binding 包装器视图
public struct BindingWrapper<Value, Content: View>: View {
    
    @ObservedObject public var viewModel: ViewModel
    let content: (Binding<Value>) -> Content
    
    public init(initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        let viewModel = ViewModel(initialValue: initialValue)
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content
    }
    
    public var body: some View {
        content($viewModel.boundProperty)
    }
}

// MARK: - 演示如何在 UIKit 中使用 BindingWrapper 包装的 SwiftUI 视图
fileprivate class ViewController: UIViewController {
    
    private var isRedViewModel = BindingWrapper<Bool, RedText>.ViewModel(initialValue: false)
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wrapper = BindingWrapper<Bool, RedText>(initialValue: false) { binding in
            RedText(isRed: binding)
        }
        
        let redTextView = UIView {
            wrapper
        }
        view.addSubview(redTextView)
        redTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.isRedViewModel = wrapper.viewModel
        wrapper.viewModel.$boundProperty
            .removeDuplicates()
            .dropFirst()
            .sink { isRed in
                print("isRed changed to: \(isRed)")
            }
            .store(in: &cancellables)
    }
}

#Preview {
    ViewController()
}
