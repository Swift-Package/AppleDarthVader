//
//  GeometryReaderView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

import SwiftUI

struct GeometryReaderView: View {
    let colors: [Color] = [.red, .orange, .yellow]

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    ForEach(colors, id: \.self) { color in
                        color
                            .frame(height: proxy.size.height / CGFloat(colors.count))
                    }
                }
            }
            .padding()

            // MARK: - 上面的代码可以用下面的 containerRelativeFrame 简化

            VStack {
                ForEach(colors, id: \.self) { color in
                    color
                        .containerRelativeFrame(.vertical, count: colors.count, spacing: 0)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GeometryReaderView()
}
