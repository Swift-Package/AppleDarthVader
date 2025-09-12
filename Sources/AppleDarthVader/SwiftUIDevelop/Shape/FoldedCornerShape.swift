//
//  FoldedCornerShape.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/2.
//

import SwiftUI

// MARK: - 自定义折角形状
public struct FoldedCornerShape: Shape {
    
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height * 0.8))
        
        path.addLine(to: CGPoint(x: width * 0.8, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    Button {
        print("开通")
    } label: {
        ZStack {
            FoldedCornerShape()
                .fill(Color.orange)
                .frame(width: 200, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("开通")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}
