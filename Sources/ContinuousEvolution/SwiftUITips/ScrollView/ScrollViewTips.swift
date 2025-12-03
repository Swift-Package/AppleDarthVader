//
//  ScrollViewTips.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/2.
//

import SwiftUI

fileprivate struct ScrollViewTips: View {
    var body: some View {
		VStack { 
			Text(verbatim: "ScorllView")
			ScrollView { 
				ForEach(0..<5) { index in
					Text("\(index)")
				}
			}
			.scrollClipDisabled()
			.defaultScrollAnchor(.bottom)
		}
    }
}

#Preview {
	ScrollViewTips()
}
