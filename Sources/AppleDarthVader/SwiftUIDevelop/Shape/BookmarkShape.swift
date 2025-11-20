//
//  BookmarkShape.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/20.
//

import SwiftUI

// MARK: - 自定义书签形状
public struct BookmarkShape: Shape {
	
	public init() {}
	
	public func path(in rect: CGRect) -> Path {
		Path { p in
			p.move(to: rect[.topLeading])
			p.addLines([
				rect[.bottomLeading],
				rect[.init(x: 0.5, y: 0.8)],
				rect[.bottomTrailing],
				rect[.topTrailing],
				rect[.topLeading]
			])
			p.closeSubpath()
		}
	}
	
	// MARK: - 确保书签形状始终拥有 2⨉3 的宽⾼⽐
	public nonisolated func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
		let ratio: CGFloat = 2 / 3
		var result = proposal.replacingUnspecifiedDimensions() // 建议尺寸可能为 nil 重新获取一个 CGSize
		let newWidth = ratio * result.height
		if newWidth <= result.width {
			result.width = newWidth
		} else {
			result.height = result.width / ratio
		}
		return result
	}
}

public extension CGRect {
	subscript(_ point: UnitPoint) -> CGPoint {
		CGPoint(x: minX + width*point.x, y: minY + height*point.y)
	}
}

#Preview {
	BookmarkShape()
		.fill(Color.orange)
		.frame(width: 500, height: 200)
		.clipShape(RoundedRectangle(cornerRadius: 12))
}
