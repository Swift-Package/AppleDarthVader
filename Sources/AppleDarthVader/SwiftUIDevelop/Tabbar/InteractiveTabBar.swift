//
//  InteractiveTabBar.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/8/2.
//

// Youtube - Kavsoft - Interactive Tab Bar | SwiftUI

import SwiftUI

public enum TabItem: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case notifications = "Notifications"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .home:
            "house"
        case .search:
            "magnifyingglass"
        case .notifications:
            "bell"
        case .settings:
            "gearshape"
        }
    }
    
    var index: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}

public struct InteractiveTabBar: View {
    
    public init(activeTab: TabItem = .home) {
        self.activeTab = activeTab
    }
    
    @State private var activeTab: TabItem = .home
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                ForEach(TabItem.allCases, id: \.rawValue) { tab in
                    Tab.init(value: tab) {
                        Text(tab.rawValue)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            }
        }
        InteractiveTabbar(activeTab: $activeTab)
    }
}

public struct InteractiveTabbar: View {
    
    @Binding var activeTab: TabItem
    
    @Namespace private var animation
    
    @State private var tabButtonLocation: [CGRect] = Array(repeating: .zero, count: TabItem.allCases.count)
    
    @State private var activeDraggingTab: TabItem?
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.rawValue) { tab in
                TabButton(tab)
            }
        }
        .frame(height: 50)
        .background {
            Capsule()
                .fill(.background.shadow(.drop(color: .primary.opacity(0.2), radius: 5)))
        }
        .coordinateSpace(.named("TABBAR"))
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func TabButton(_ tab: TabItem) -> some View {
        let isActive = (activeDraggingTab ?? activeTab) == tab
        
        VStack(spacing: 6) {
            Image(systemName: tab.symbolImage)
                .symbolVariant(.fill)
                .frame(width: isActive ? 50 : 25, height: isActive ? 50 : 25)
                .background {
                    if isActive {
                        Circle()
                            .fill(.blue.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
                .contentShape(.rect)
                .frame(width: 25, height: 25, alignment: .bottom)
                .foregroundStyle(isActive ? .white : .primary)
            Text(tab.rawValue)
                .font(.caption2)
                .foregroundStyle(isActive ? .blue : .gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onGeometryChange(for: CGRect.self, of: { proxy in
            proxy.frame(in: .named("TABBAR"))
        }, action: { newValue in
            tabButtonLocation[tab.index] = newValue
        })
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.snappy) {
                activeTab = tab
            }
        }
        .gesture(
            DragGesture(coordinateSpace: .named("TABBAR"))
                .onChanged{ value in
                    // 检查是否落在最近的选项上 如果是切换过去
                    let location = value.location
                    if let index = tabButtonLocation.firstIndex(where: { rect in
                        rect.contains(location)
                    }) {
                        withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                            activeDraggingTab = TabItem.allCases[index]
                        }
                    }
                }
                .onEnded{ _ in
                    if let activeDraggingTab {
                        activeTab = activeDraggingTab
                    }
                    activeDraggingTab = nil
                }, isEnabled: activeTab == tab
        )
    }
}

#Preview {
    InteractiveTabBar()
}
