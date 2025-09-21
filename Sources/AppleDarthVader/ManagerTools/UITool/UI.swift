//
//  UI.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

/// 用来判断设备及用户界面特征
@MainActor
@objcMembers
public class UI: NSObject {
    
     public static let shared = UI()

    public var isPortrait: Bool {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first!.interfaceOrientation.isPortrait
    }

    public var isiPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
}
