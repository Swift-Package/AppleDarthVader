//
//  StarReview.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/4/13.
//

import StoreKit
import UIKit

@MainActor
public func appReview() {
    if let scene = UIApplication.shared.connectedScenes.first(where: { scene in
        scene.activationState == .foregroundActive
    }) as? UIWindowScene {
        AppStore.requestReview(in: scene)
    }
}
