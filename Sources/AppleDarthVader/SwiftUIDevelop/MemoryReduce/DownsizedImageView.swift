//
//  DownsizedImageView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/31.
//

// Youtube - Kavsoft - Reduce Memory Consumption when using Large Images | SwiftUI

import SwiftUI

public extension CGSize {
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / width
        let scaleY = to.height / height
        let aspectRatio = min(scaleX, scaleY)
        return .init(width: aspectRatio * width, height: aspectRatio * height)
    }
}

// MARK: - 降低内存使用的图片视图
public struct DownsizedImageView<Content: View>: View {
    
    public init(image: UIImage?, size: CGSize, @ViewBuilder content: @escaping (Image) -> Content) {
        self.image = image
        self.size = size
        self.content = content
    }
    
    var image: UIImage?
    var size: CGSize
    
    @ViewBuilder var content: (Image) -> Content
    @State private var downsizedImageView: Image?
    
    public var body: some View {
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
            let resizedImage = renderer.image { context in
                image.draw(in: .init(origin: .zero, size: aspectSize))
            }
            
            await MainActor.run {
                downsizedImageView = .init(uiImage: resizedImage)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                VStack {
                    ForEach(1...300, id: \.self) { _ in
                        if let image = UIImage(named: "奥德赛8K", in: Bundle.module, with: nil) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 150)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
//    var body: some View {
//        NavigationView {
//            List {
//                VStack {
//                    ForEach(1...300, id: \.self) { _ in
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
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
