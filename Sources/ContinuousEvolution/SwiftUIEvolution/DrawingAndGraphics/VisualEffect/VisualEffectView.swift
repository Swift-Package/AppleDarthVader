//
//  VisualEffectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import SwiftUI

struct VisualEffectView: View {
    
    let colors: [Color] = [.red, .orange, .yellow, .purple]
    
    var body: some View {
        VStack {
            ForEach(0..<6) { index in
                colors[index % colors.count]
                    .frame(height: 100)
                    .visualEffect { content, proxy in
                        content
                            .rotationEffect(.degrees(proxy.frame(in: .global).origin.y / 45))
                    }
            }
        }
        .padding()
    }
}

#Preview {
    VisualEffectView()
}
