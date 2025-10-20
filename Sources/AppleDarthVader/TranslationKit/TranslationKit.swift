//
//  TranslationKit.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/18.
//

import SwiftUI
import Translation

fileprivate struct TranslationKitView: View {
    
    @State private var showTranslation = false
    @State private var originalText = "iOS 18 之后在应用程序中可以使用翻译 API。"
    @State private var configuration: TranslationSession.Configuration?// 翻译配置
    
    //    var body: some View {
    //        VStack {
    //            Text(originalText)
    //
    //            Button("Translate") {
    //                showTranslation.toggle()
    //            }
    //        }
    //        .padding()
    //        .translationPresentation(isPresented: $showTranslation, text: originalText) { translatedText in
    //            print(translatedText)
    //            originalText = translatedText
    //        }
    //    }
    
    var body: some View {
        NavigationStack {
            Text(originalText)
                .toolbar {
                    Button {
                        configuration = TranslationSession.Configuration(source: .init(identifier: "zh-Hans-CN"), target: .init(identifier: "en-US"))
                    } label: {
                        Label("Translate", systemImage: "translate")
                            .labelStyle(.iconOnly)
                    }
                }
                .translationTask(configuration) { session in
                    // 翻译
                    Task {
                        if let response = try? await session.translate(originalText) {
                            originalText.append("\n\n" + response.targetText)
                        }
                    }
                }
        }
    }
}

#Preview {
    TranslationKitView()
}

