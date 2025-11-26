//
//  EnvironmentObjectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

// MARK: - 教程来源
// 1.How to Use @Environment & @EnvironmentObject in 2025 - https://www.youtube.com/watch?v=5enyOSqkL-w
// 2.Create Environment Objects in One Line Using SwiftUI’s Entry Macro - https://www.youtube.com/watch?v=d976O4pIX9s
// 3.Adding keys to SwiftUI's environment with Xcode 16 and @Entry - https://www.youtube.com/watch?v=a90IYC8rxcY&t=9s
// 4.全局主题色 SwiftUI’s Entry Macro: Simplifying Environment Keys & Theming - https://www.youtube.com/watch?v=nun_jIRiYP0&t=295s
// 5.SwiftUI Entry Macros: The Easiest Way to Make Your Code Look Pro - https://www.youtube.com/watch?v=_SDytQat-iU&t=19s
// 6.@Entry SwiftUI Environment Macro - https://www.youtube.com/watch?v=n0oN4PSB0Y0
// 7.Don't write this code! (use the @Entry macro instead 😌) - https://www.youtube.com/watch?v=kmigO5TSlDY
// 8.SwiftUI 编程思想 - 环境章节

import SwiftUI

@Observable
class AppSettings {
    
    var isDarkModeForced = false
    var preferedFontSize: Double = 16
    var enableNotification = false
    
    var effectiveColorScheme: ColorScheme? {
        isDarkModeForced ? .dark : nil
    }
}

struct EnvironmentObjectView: View {
    
    @Environment(AppSettings.self) private var settings
    
    var body: some View {
		// 在 Body 中直接生成绑定
        @Bindable var bindableSettings = settings
        
        Form {
            Section("Appearance") {
                Toggle(isOn: $bindableSettings.isDarkModeForced) {
                    Text("强制暗黑模式")
                }
                
                HStack {
                    Text("字体大小")
                    Slider(value: $bindableSettings.preferedFontSize, in: 12...20, step: 1)
                    Text("\(Int(settings.preferedFontSize))")
                }
            }
        }
    }
}

#Preview {
    EnvironmentObjectView()
        .environment(AppSettings())
}
