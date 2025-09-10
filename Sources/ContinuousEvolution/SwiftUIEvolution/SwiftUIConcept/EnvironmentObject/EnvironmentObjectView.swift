//
//  EnvironmentObjectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

// How to Use @Environment & @EnvironmentObject in 2025 - https://www.youtube.com/watch?v=5enyOSqkL-w

import Observation
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
        @Bindable var bindableSettings = settings

        Form {
            Section("Appearance") {
                Toggle(isOn: $bindableSettings.isDarkModeForced) {
                    Text("强制暗黑模式")
                }

                HStack {
                    Text("字体大小")
                    Slider(value: $bindableSettings.preferedFontSize, in: 12 ... 20, step: 1)
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
