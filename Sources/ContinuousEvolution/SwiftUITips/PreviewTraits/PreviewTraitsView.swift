//
//  PreviewTraitsView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2026/1/5.
//

import SwiftUI

fileprivate struct PreviewTraitsView: View {
    var body: some View {
		Text("Hello SwiftUI")
    }
}

#Preview {
	PreviewTraitsView()
}

#Preview("暗黑模式", traits: .darkMode, .dynamicType(size: .accessibility3)) {
	PreviewTraitsView()
}

// MARK: - 可以通过实现 PreviewModifier 协议创建自定义的预览特性
public struct DarkModeTrait: PreviewModifier {
	public func body(content: Content, context: Void) -> some View {
		content
			.preferredColorScheme(.dark)
	}
}

public struct DynamicTypeTrait: PreviewModifier {
	
	public let size: DynamicTypeSize
	
	public func body(content: Content, context: Void) -> some View {
		content
			.environment(\.dynamicTypeSize, size)
	}
}

public extension PreviewTrait where T == Preview.ViewTraits {
	static var darkMode: Self = .modifier(DarkModeTrait())
	
	static func dynamicType(size: DynamicTypeSize) -> Self {
		.modifier(DynamicTypeTrait(size: size))
	}
}
