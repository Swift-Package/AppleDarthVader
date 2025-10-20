//
//  ConvenienceBindableView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/20.
//

// @Observable @Bindable in iOS17 - SwiftUI Data Flow - Rebeloper - Rebel Developer

import SwiftUI

// MARK: - 便利绑定概念
struct Person {
    var name = "A"
}

@Observable
class AppState {
    
    var person = Person()
    
    func fetchPerson() {
        person = Person(name: "New Name")
    }
}

fileprivate struct ConvenienceBindableView: View {
    
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack(spacing: 12) {
            // MARK: - 1.简单取值
            Text(appState.person.name)
                .foregroundStyle(.black)
            
            // MARK: - 2.简单改变
            Button {
                appState.fetchPerson()
            } label: {
                Text("Change Name")
            }
            
            // MARK: - 3.便利绑定
            // TextField("Name", text: $appState.person.name)// ⚠️无法这样绑定
            TextField("Name", text: Bindable(appState).person.name)
            
        }
        .padding()
    }
}

#Preview {
    ConvenienceBindableView()
        .environment(AppState())
}
