//
//  FakeSwitchView.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/11/15.
//

// SwiftUI Animations: A Deep Dive with Chris Eidhof and Florian Kugler from objc.io
// https://www.youtube.com/watch?v=AfhUHEkS7Ew

import SwiftUI

fileprivate struct FakeSwitchView: View {
    
    @State var isOn = false
    
    var body: some View {
        Capsule()
            .fill(isOn ? .green : .gray)
            .frame(width: 100, height: 50)
            .overlay(alignment: isOn ? .trailing : .leading) {
                Circle()
                    .fill(.white)
                    .padding(4)
            }
            .animation(.spring(), value: isOn)
            .onTapGesture {
                isOn.toggle()
            }
    }
}

#Preview {
    FakeSwitchView()
}
