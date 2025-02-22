//
//  NetworkMonitorForSwiftUI.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import Foundation
import Network

public class NetworkMonitorForSwiftUI: ObservableObject {
    static let shared = NetworkMonitorForSwiftUI()

    private let monitor: NWPathMonitor
    @Published var currentInterface: NWInterface.InterfaceType = .wifi
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")

    private init() {
        monitor = NWPathMonitor()
    }

    public func start() {
        monitor.pathUpdateHandler = { path in
            guard let interface = NWInterface.InterfaceType.allCases.filter({ interFaceType in path.usesInterfaceType(interFaceType) }).first else { return }

            DispatchQueue.main.sync { [weak self] in
                self?.currentInterface = interface
            }
        }

        monitor.start(queue: queue)
    }

    public func stop() {
        monitor.cancel()
    }
}
