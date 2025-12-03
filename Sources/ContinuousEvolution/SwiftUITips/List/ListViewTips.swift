//
//  ListViewTips.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/3.
//

import SwiftUI

fileprivate struct ListViewTips: View {
    var body: some View {
		List { 
			Section { 
				Text(verbatim: "iPhone 17 Pro Max")
			}
			
			Section { 
				ForEach(0..<66) { _ in 
					Text(verbatim: "iPhone 17 Pro Max")
				}
			}
		}
		.listSectionSpacing(16)
		.defaultScrollAnchor(.bottom)
    }
}

#Preview {
	ListViewTips()
}
