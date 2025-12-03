//
//  SystemEnvironmentView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

import SwiftUI

fileprivate struct SystemEnvironmentView: View {
    
	@Environment(\.openURL) var openURL
    @Environment(\.scenePhase) var scenePhase
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.verticalSizeClass) var verticalSizeClass
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@Environment(\.dynamicTypeSize.isAccessibilitySize) private var isAccessibilitySize
    
    @State var backgroundTime: Date?
    
    var body: some View {
        VStack {
            Button {
                openURL(URL(string: "Apple.com")!, prefersInApp: true)
            } label: {
				HStack {
					Text("Open Apple.com")
					Text("Open")
						.textCase(.none)
				}
            }
            Group {
                if verticalSizeClass == .compact {
                    if let backgroundTime {
                        Text("应用切换到后的时间 \(backgroundTime, style: .time)")
                    }
                }
            }
        }
		.environment(\.textCase, .uppercase)
        .onChange(of: scenePhase) { _, newScenePhase in
            switch newScenePhase {
            case .background:
                backgroundTime = Date()
            case .inactive:
                break
            case .active:
                break
            @unknown default:
                break
            }
        }
    }
}

#Preview {
	SystemEnvironmentView()
}
