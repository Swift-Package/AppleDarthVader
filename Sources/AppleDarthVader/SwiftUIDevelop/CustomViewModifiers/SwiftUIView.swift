//
//  SwiftUIView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/7.
//

// 元素渐显的自定义线段布局 - https://www.youtube.com/watch?v=OEllsHKpn80

import SwiftUI

fileprivate struct SwiftUIView: View {
	
	@State var show = false
	
    var body: some View {
		VStack {
			InlineFlow(horizontalSpacing: 12, verticalSpacing: 8, rowHeight: 50) {
				Text("Hello SwiftUI SwiftUI SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.1)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.2)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.5)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.8)
				Text("Hello")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.8)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 0.9)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 1)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 1.1)
				Text("Hello")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 1.2)
				Text("Hello SwiftUI")
					.padding()
					.background(.blue.opacity(0.2))
					.clipShape(.capsule)
					.blurFromBottom(show, delay: 1.3)
			}
		}
		.onAppear {
			show = true
		}
    }
}

#Preview {
    SwiftUIView()
}

public struct SlideInFromBottom: ViewModifier {
	
	var isVisible: Bool
	var deley: Double = 0
	
	public func body(content: Content) -> some View {
		content
			.opacity(isVisible ? 1: 0)
			.offset(y: isVisible ? 0 : 50)
			.blur(radius: isVisible ? 0 : 10)
			.animation(.easeOut(duration: 1).delay(deley), value: isVisible)
	}
}

public extension View {
	func blurFromBottom(_ isVisible: Bool, delay: Double = 0) -> some View {
		modifier(SlideInFromBottom(isVisible: isVisible, deley: delay))
	}
}

public struct InlineFlow: Layout {
	
	var horizontalSpacing: CGFloat = 6
	var verticalSpacing: CGFloat = 0
	var rowHeight: CGFloat = 30
	
	public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		let maxWidth = proposal.width ?? .infinity
		var x: CGFloat = 0
		var y: CGFloat = 0
		for v in subviews {
			let s = v.sizeThatFits(.unspecified)
			if x + s.width > maxWidth {
				x = 0
				y += rowHeight + verticalSpacing
			}
			x += s.width + horizontalSpacing
		}
		return CGSize(width: maxWidth, height: y + rowHeight)
	}
	
	public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		var x = bounds.minX
		var y = bounds.minY
		for v in subviews {
			let s = v.sizeThatFits(.unspecified)
			if x + s.width > bounds.maxX {
				x = bounds.minX
				y += rowHeight + verticalSpacing
			}
			v.place(at: CGPoint(x: x, y: y + (rowHeight - s.height) / 2 ), proposal: ProposedViewSize(s))
			x += s.width + horizontalSpacing
		}
	}
}
