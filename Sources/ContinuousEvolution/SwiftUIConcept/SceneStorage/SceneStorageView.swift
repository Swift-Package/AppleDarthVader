//
//  SceneStorageView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/4.
//

import SwiftUI

struct SceneStorageView: View {
    var body: some View {
		GeometryReader { geometry in  
			Text("Width: \(geometry.size.width)")  
				.frame(maxWidth: .infinity)  
				.background(Color.blue.safeAreaPadding(.all))
				.border(.red)
		}  
		.background(Color.gray.opacity(0.2))  
    }
}

#Preview {
	SceneStorageView()
}

// SceneStorage 只能工作在场景管理的视图下
