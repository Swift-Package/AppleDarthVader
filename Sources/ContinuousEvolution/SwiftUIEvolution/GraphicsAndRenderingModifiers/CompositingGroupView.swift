//
//  CompositingGroupView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/27.
//

import SwiftUI

struct CompositingGroupView: View {
    var body: some View {
		VStack { 
			RoundedRectangle(cornerRadius: 25)
				.fill(.mint)
				.frame(width: 350, height: 150)
				.offset(y: 50)
				.zIndex(1)
			
			RoundedRectangle(cornerRadius: 25)
				.fill(.mint)
				.frame(width: 150, height: 350)
		}
		.compositingGroup()// 合并
		.shadow(color: .black, radius: 30, y: 30)
    }
}

#Preview {
	CompositingGroupView()
}
