//
//  PositionView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/27.
//

import SwiftUI

fileprivate struct PositionView: View {
    var body: some View {
		ZStack { 
			Color.mint.opacity(0.5)
			
			Rectangle()
				.fill(.purple)
				.frame(width: 100, height: 100)
				.position(.init(x: 100, y: 100))
		}
		.frame(width: 350, height: 350)
    }
}

#Preview {
	PositionView()
}
