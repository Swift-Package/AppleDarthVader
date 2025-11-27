//
//  ViewThatFitsFuncView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/27.
//

import SwiftUI

// MARK: - 自适应水平垂直布局(不同屏幕尺寸的情况会自适应选择一种布局方式)
fileprivate struct ViewThatFitsFuncView: View {
    var body: some View {
		ViewThatFits(in: .horizontal) { 
			HStack { 
				Text("Restore previous purchases")
				
				Button("Restore Purchases") {
					
				}
				.buttonStyle(.borderedProminent)
			}
			
			VStack { 
				Text("Restore previous purchases")
				
				Button("Restore Purchases") {
					
				}
				.buttonStyle(.borderedProminent)
			}
		}
    }
}

#Preview {
	ViewThatFitsFuncView()
}
