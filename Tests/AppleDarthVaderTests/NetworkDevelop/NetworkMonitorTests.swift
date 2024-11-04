//
//  NetworkMonitorTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import XCTest

final class NetworkMonitorTests: XCTestCase {
    func testExample() throws {
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }

    @objc func showOfflineDeviceUI(notification _: Notification) {
        if NetworkMonitor.shared.isConnected {
            print("Skywalker Network Connected")
        } else {
            print("Skywalker Not Network Connected")
        }
    }
}
