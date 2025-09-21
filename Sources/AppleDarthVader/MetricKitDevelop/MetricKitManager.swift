//
//  MetricKitManager.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import MetricKit

@MainActor
public class MetricKitManager: NSObject {
    
    public static let shared = MetricKitManager()

    override private init() {
        super.init()
    }

    deinit {
        MainActor.assumeIsolated {
            MXMetricManager.shared.remove(self)
        }
    }

    /// 启动MetricKit性能监控
    public func startMonitor() {
        MXMetricManager.shared.add(self)

        let metricLogHandle = MXMetricManager.makeLogHandle(category: "AppleDarthVader")
        mxSignpost(.event, log: metricLogHandle, name: "AppleDarthVader 启动性能检测")
    }
}

@MainActor
extension MetricKitManager: @MainActor MXMetricManagerSubscriber {
    public func didReceive(_ payloads: [MXMetricPayload]) {
        guard let firstPayload = payloads.first else { return }
        print("AppleDarthVader \(firstPayload.dictionaryRepresentation())")
    }

    @available(iOS 14.0, *)
    public func didReceive(_ payloads: [MXDiagnosticPayload]) {
        guard let firstPayload = payloads.first else { return }
        print("AppleDarthVader \(firstPayload.dictionaryRepresentation())")
    }
}
