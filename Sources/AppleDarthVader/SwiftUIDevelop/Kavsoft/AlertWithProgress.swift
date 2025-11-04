//
//  SwiftUIView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/3.
//

// 教程来源 - https://www.youtube.com/watch?v=6p2syzm0Wuo

import SwiftUI

// MARK: - 演示带进度条弹窗
fileprivate struct SwiftUIView: View {
    
    @State private var showAlert = false
    @State private var progress: CGFloat = 0.0
    @State private var config: ProgressAlertConfig = .init(title: "Downloading\nHello World\n", message: "Please wait until it finishes!")
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    showAlert.toggle()
                    
                    Task {
                        for _ in 1...10 {
                            try? await Task.sleep(for: .seconds(1))
                            progress += 0.1
                        }
                    }
                } label: {
                    Text("Show Alert")
                }
            }
            .navigationTitle("Progress Alert")
            .progressAlert(config: config, isPresented: $showAlert, progress: $progress) {
                Button("Cancel", role: .cancel) {
                    progress = 0
                }
            }
        }
    }
}

// MARK: - 进度条弹窗配置
public struct ProgressAlertConfig {
    
    var tint: Color = .blue
    var title: String
    var message: String
    // MARK: - 提供两种设置进度视图偏移量的方法,一种是手动强制设置偏移量
    // MARK: - 另一种是自动读取警告视图的内容高度并将其设为偏移量,这样进度视图就会显示在标签内容下方和操作按钮上方
    var forceFallback: Bool = false
    var fallbackOffset: CGFloat = 50
}

public extension View {
    @ViewBuilder
    func progressAlert<Actions: View>(config: ProgressAlertConfig, isPresented: Binding<Bool>, progress: Binding<CGFloat>, @ViewBuilder action: @escaping () -> Actions) -> some View {
        self
            .alert(config.title, isPresented: isPresented) {
                action()
            } message: {
                Text("\(config.message)\(config.forceFallback ? "" : "\n")")
            }
            .background {
                if isPresented.wrappedValue {
                    AttachProgressWithAlert(config: config, progress: progress)
                }
            }
    }
}

struct AttachProgressWithAlert: UIViewRepresentable {
    
    var config: ProgressAlertConfig
    @Binding var progress: CGFloat
    @State private var progressBar: UIProgressView?
    
    // MARK: - 创建视图
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        print("Hello")
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if let currentController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController,
               let alertController = currentController.presentedViewController as? UIAlertController {
                print(alertController)
                addProgressBar(alertController)
            }
        }
        return view
    }
    
    // MARK: - 更新视图
    func updateUIView(_ uiView: UIView, context: Context) {
        if let progressBar {
            progressBar.progress = Float(progress)
            progressBar.tintColor = UIColor(config.tint)
        }
    }
    
    // MARK: - 视图消失处理
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        
    }
    
    private func addProgressBar(_ controller: UIAlertController) {
        let progressView = UIProgressView()
        progressView.tintColor = UIColor(config.tint)
        progressView.progress = Float(progress)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = isiOS26 ? 30 : 15
        controller.view.addSubview(progressView)
        progressView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: padding).isActive = true
        progressView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -padding).isActive = true
        // MARK: - 决定如何设置偏移量
        var offset = config.fallbackOffset
        if !config.forceFallback {
            if let contentView = controller.view.allSubviews().first(where: { view in
                String(describing: type(of: view)).contains("GroupHeaderScrollView")
            }) {
                offset = contentView.frame.height - (isiOS26 ? 8 : 20)
            }
        }
        progressView.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: offset).isActive = true
        self.progressBar = progressView
    }
    
    var isiOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }
}

// MARK: - 提取出 UIView 的所有子视图
public extension UIView {
    func allSubviews() -> [UIView] {
        var result = self.subviews.compactMap { $0 }
        for sub in self.subviews {
            result.append(contentsOf: sub.allSubviews())
        }
        return result
    }
}

#Preview {
    SwiftUIView()
}
