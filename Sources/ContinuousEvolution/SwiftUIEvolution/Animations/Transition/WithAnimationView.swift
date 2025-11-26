//
//  WithAnimationView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/25.
//

// 教程来源 - https://www.youtube.com/watch?v=0Xd1qw8Sgv0

import SwiftUI

fileprivate struct WithAnimationView: View {
	
	@State var smallViews = true
	
    var body: some View {
		VStack {
			Rectangle()
				.fill(.blue)
				.frame(width: smallViews ? 100 : 200, height: 100)
				// .animation(.default, value: smallViews)// 也可以单独管理动画
			
			Rectangle()
				.fill(.red)
				.frame(width: smallViews ? 100 : 200, height: 100)
				.transaction { transaction in
					transaction.animation = nil// 屏蔽动画
				}
			
			Button {
				withAnimation(.default) {
					smallViews.toggle()
				}
			} label: { 
				Text("Toggle")
			}
		}
    }
}

#Preview {
	WithAnimationView()
}
