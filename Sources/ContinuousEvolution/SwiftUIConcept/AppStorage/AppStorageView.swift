//
//  AppStorageView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/19.
//

import SwiftUI

fileprivate struct AppStorageView: View {
    
    @State private var isBellSlash = UserDefaults.standard.bool(forKey: "isBellSlash")
    
    @AppStorage("isBellSlashs") private var isBellSlashs = false
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $isBellSlash) {
                    HStack {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                        Text("消息通知")
                    }
                }
                .onChange(of: isBellSlash) { oldValue, newValue in
                    UserDefaults.standard.set(newValue, forKey: "isBellSlash")
                }
                
                Toggle(isOn: $isBellSlashs) {
                    HStack {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                        Text("消息通知")
                    }
                }
            }
        }
    }
}

#Preview {
    AppStorageView()
}
