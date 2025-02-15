//
//  SwiftUIDebug.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/12/10.
//

import SwiftUI

public extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
