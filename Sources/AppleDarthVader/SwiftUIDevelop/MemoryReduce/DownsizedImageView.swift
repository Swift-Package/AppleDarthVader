//
//  DownsizedImageView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/31.
//

// Youtube - Kavsoft - Reduce Memory Consumption when using Large Images | SwiftUI

import SwiftUI

// MARK: - 降低内存使用的图片展示组件

struct DownsizedImageView<Content: View>: View {
    var image: UIImage?
    var size: CGSize

    @State private var downsizedImageView: Image?
    @ViewBuilder var content: (Image) -> Content

    var body: some View {
        ZStack {
            if let downsizedImageView {
                content(downsizedImageView)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            guard downsizedImageView == nil else { return }
            createDownsizedImage(image)
        }
        .onChange(of: image) { oldValue, newValue in
            guard oldValue != newValue else { return }
        }
    }

    private func createDownsizedImage(_ image: UIImage?) {
        guard let image else { return }
        let aspectSize = image.size.aspectFit(size)
        Task.detached(priority: .high) {
            let renderer = UIGraphicsImageRenderer(size: aspectSize)
            let resizedImage = renderer.image { _ in
                image.draw(in: .init(origin: .zero, size: aspectSize))
            }

            await MainActor.run {
                downsizedImageView = .init(uiImage: resizedImage)
            }
        }
    }
}

extension CGSize {
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / width
        let scaleY = to.height / height
        let aspectRatio = min(scaleX, scaleY)
        return .init(width: aspectRatio * width, height: aspectRatio * height)
    }
}

// MARK: - 测试代码

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                VStack {
                    ForEach(1 ... 300, id: \.self) { _ in
                        if let image = UIImage(named: "奥德赛8K") {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .clipShape(.rect(cornerRadius: 10))
                        }
//                        let size = CGSize(width: 150, height: 150)
//                        DownsizedImageView(image: UIImage(named: "奥德赛8K"), size: size) { image in
//                            GeometryReader { proxy in
//                                let size = proxy.size
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: size.width, height: size.height)
//                                    .clipShape(.rect(cornerRadius: 10))
//                            }
//                            .frame(height: 150)
//                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
