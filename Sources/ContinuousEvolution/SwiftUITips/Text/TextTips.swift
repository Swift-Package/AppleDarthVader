//
//  TextTips.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

// SwiftUI 中自定义文本颜色的方法 - https://nilcoalescing.com/blog/ForegroundColorStyleAndTintInSwiftUI/

import SwiftUI

struct TextTips: View {
    var body: some View {
		Text(timerInterval: .now...Date.init(timeIntervalSinceNow: 90), countsDown: false)
    }
}

#Preview {
	TextTips()
}
