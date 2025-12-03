//
//  EnvironmentObjectView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/31.
//

// 教程来源 - How to Use @Environment & @EnvironmentObject in 2025 - https://www.youtube.com/watch?v=5enyOSqkL-w

import SwiftUI

@Observable
class AppSettings {
    
    var isDarkModeForced = false
    var preferedFontSize: Double = 17
    var enableNotification = false
    
    var effectiveColorScheme: ColorScheme? {
        isDarkModeForced ? .dark : nil
    }
}

struct EnvironmentObjectView: View {
    
    @Environment(AppSettings.self) private var settings
    
    var body: some View {
		// 无法直接将 @Environment 对象的属性绑定到视图需要通过 @Bindable
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

// MARK: - 低于 iOS 17 的版本
class AppSettingsX: ObservableObject {
	
	@Published var isDarkModeForced = false
	@Published var preferedFontSize: Double = 16
	@Published var enableNotification = false
}


struct EnvironmentObjectView1: View {
	
	@EnvironmentObject private var settings: AppSettingsX
	
	var body: some View {
		Form {
			Section("Appearance") {
				Toggle(isOn: $settings.isDarkModeForced) {
					Text("强制暗黑模式")
				}
				
				HStack {
					Text("字体大小")
					Slider(value: $settings.preferedFontSize, in: 12...20, step: 1)
					Text("\(Int(settings.preferedFontSize))")
				}
			}
		}
	}
}

#Preview {
	@Previewable @StateObject var settings = AppSettingsX()
	EnvironmentObjectView1()
		.environmentObject(settings)
}
