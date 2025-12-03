//
//  EntryMacroView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/27.
//

import SwiftUI

fileprivate extension EnvironmentValues {
	@Entry var userID: String = "No UserID"
}

fileprivate struct EntryMacroView: View {
	
	@Environment(\.userID) private var userID
	
    var body: some View {
		Text(userID)
    }
}

#Preview {
	EntryMacroView()
}

#Preview {
	EntryMacroView()
		.environment(\.userID, "1234")
}

// MARK: - 没有 @Entry 宏之前的处理方式比较繁琐(已经淘汰)
fileprivate class Sorted {
	nonisolated(unsafe) static let shared = Sorted()
}

fileprivate struct SortedKey: EnvironmentKey {
	nonisolated(unsafe) static let defaultValue: Sorted = Sorted.shared
}

fileprivate extension EnvironmentValues {
	var sorted: Sorted {
		get { self[SortedKey.self] }
		set { self[SortedKey.self] = newValue }
	}
}

// MARK: - 使用 @Entry 宏
fileprivate extension EnvironmentValues {
	@Entry var sortedE: Sorted = Sorted.shared
}

// MARK: - 没有 @Entry 宏之前的处理方式比较繁琐
fileprivate struct DateFormatterKey: EnvironmentKey {
	static let defaultValue: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd/yyyy"
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
}

fileprivate extension EnvironmentValues {
	var dateFormatter: DateFormatter {
		get { self[DateFormatterKey.self] }
		set { self[DateFormatterKey.self] = newValue }
	}
}
