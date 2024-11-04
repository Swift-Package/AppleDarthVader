//
//  WKWebViewExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import WebKit

@objc
public extension WKWebView {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }

        load(URLRequest(url: url))
    }
}
