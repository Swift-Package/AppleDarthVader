//
//  RxCLLocationManager.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/20.
//

// 该 RxSwift 扩展来自 Kodeco 网站 - RxSwift 书籍教程项目 Wundercast
// https://www.kodeco.com/books/rxswift-reactive-programming-with-swift/v4.0/chapters/13-intermediate-rxcocoa

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

// MARK: - 告诉 Rx 这个对象有 Delegate 所以可以被 DelegateProxy 接管
extension CLLocationManager: @retroactive HasDelegate {}

// MARK: - 通过这个扩展告诉 Rx CLLocationManager.Delegate == CLLocationManagerDelegate
public extension Reactive where Base: CLLocationManager {
	var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
		RxCLLocationManagerDelegateProxy.proxy(for: base)
	}
	
	var didUpdateLocations: Observable<[CLLocation]> {
		delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
			.map { parameters in
				parameters[1] as! [CLLocation]
			}
	}
	
	var authorizationStatus: Observable<CLAuthorizationStatus> {
		delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManagerDidChangeAuthorization(_:)))
			.map { parameters in
				(parameters[0] as! CLLocationManager).authorizationStatus
			}
			.startWith(CLLocationManager.init().authorizationStatus)
	}
	
	func getCurrentLocation() -> Observable<CLLocation> {
		let location = authorizationStatus
			.filter { $0 == .authorizedWhenInUse || $0 == .authorizedAlways }
			.flatMap { _ in self.didUpdateLocations.compactMap(\.first) }
			.take(1)
			.do(onDispose: { [weak base] in base?.stopUpdatingLocation() })
		
		base.requestWhenInUseAuthorization()
		base.startUpdatingLocation()
		return location
	}
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
	
	weak public private(set) var locationManager: CLLocationManager?
	
	public init(locationManager: ParentObject) {
		self.locationManager = locationManager
		super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
	}
	
	// MARK: - DelegateProxyType 协议的注册方法告诉 Rx：当需要 CLLocationManager 的 delegate proxy 时请用这个构造方法创建
	static func registerKnownImplementations() {
		register { parent in
			RxCLLocationManagerDelegateProxy(locationManager: parent)
		}
	}
}
// 继承 DelegateProxy<Parent, Delegate> 表示
// 	•	ParentObject：CLLocationManager
//  •	Delegate：CLLocationManagerDelegate
// 👉 这个 Proxy 会：
//  •	成为 locationManager.delegate
//  •	拦截 delegate 回调
//  •	再转发给“真正的 delegate”（如果存在）
//
// 遵守 CLLocationManagerDelegate 让这个 Proxy 能接收系统回调
//
// 初始化方法
// 1.保存 parent（CLLocationManager）
// 2.调用 DelegateProxy 的核心初始化
// 3.告诉 Rx：
// 	•	我是谁
// 	•	我的 parent 是谁
// 	•	我的 proxy 类型是什么
// 👉 这一步完成后将会 locationManager.delegate = proxy
