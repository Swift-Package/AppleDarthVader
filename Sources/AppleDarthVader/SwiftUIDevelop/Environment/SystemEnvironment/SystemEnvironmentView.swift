//
//  SystemEnvironmentView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

// How to Use @Environment & @EnvironmentObject in 2025 - https://www.youtube.com/watch?v=5enyOSqkL-w

import SwiftUI

struct SystemEnvironment: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.openURL) var openURL
    
    @State var backgroundTime: Date?
    
    var body: some View {
        VStack {
            Button {
                openURL(URL(string: "Apple.com")!)
            } label: {
                Text("Open Apple.com")
            }
            Group {
                if verticalSizeClass == .compact {
                    if let backgroundTime {
                        Text("应用切换到后的时间 \(backgroundTime, style: .time)")
                    }
                } else {
                    
                }
            }
        }
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
    SystemEnvironment()
}
