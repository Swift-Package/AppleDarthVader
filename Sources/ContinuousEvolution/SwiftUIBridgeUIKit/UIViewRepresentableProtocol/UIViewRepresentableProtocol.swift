//
//  UIViewRepresentableProtocol.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/18.
//

import SwiftUI

fileprivate struct ActivityIndicatorView: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .cyan
        return activityIndicator
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

fileprivate struct UIViewRepresentableProtocol: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ActivityIndicatorView(isAnimating: $isAnimating)
                .frame(width: 50, height: 50)
            
            Button {
                isAnimating.toggle()
            } label: {
                Text(isAnimating ? "Stop" : "Start")
            }
        }
    }
}

#Preview {
    UIViewRepresentableProtocol()
}
