//
//  RedefineSystemEnvironmentView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/3.
//

// 教程来源 - https://nilcoalescing.com/blog/SwiftUIEnvironment/

import SwiftUI

fileprivate struct ContentView: View {
	
	var body: some View {
		RedefineSystemEnvironmentView()
			.environment(\.openURL, OpenURLAction(handler: { url in
				handleURL(url)
				return .handled
			}))
		
		Text("Check out [our policy](https://example.com) for more details.")
			.environment(\.openURL, OpenURLAction { url in
				handleURL1(url)
				return .handled
			})
	}
	
	func handleURL(_ url: URL) {
		print("处理URL")
	}
	
	func handleURL1(_ url: URL) {
		print("处理URL1")
	}
}

fileprivate struct RedefineSystemEnvironmentView: View {
	
	@Environment(\.openURL) private var openURL
	
	private let url = URL(string: "https://www.apple.com")!
	
	var body: some View {
		Button("OpenURL") {
			openURL(url, prefersInApp: true)// 被重新定义了
		}
	}
}

#Preview {
	ContentView()
}

// 如果需要自定义行为我们可以在环境中覆盖默认设置 OpenURLAction
