//
//  UIControlExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

private class ControlClosureWrapper {
    let controlEvents: UIControl.Event
    let action: UIControl.Action

    init(_ controlEvents: UIControl.Event, _ action: @escaping UIControl.Action) {
        self.controlEvents = controlEvents
        self.action = action
    }

    @objc func actionExcute(_ sender: UIControl) {
        action(sender)
    }
}

public extension UIControl {
    typealias Action = (_ sender: UIControl) -> Void

    private static let ControlClosureAssociatedKey = UnsafeRawPointer(bitPattern: "ControlClosureAssociatedKey".hashValue)!

    private var closureWrapper: [UInt: ControlClosureWrapper] {
        get {
            objc_getAssociatedObject(self, UIControl.ControlClosureAssociatedKey) as? [UInt: ControlClosureWrapper] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, UIControl.ControlClosureAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addEventAction(for controlEvent: UIControl.Event, action: @escaping Action) {
        let wrapperValue = ControlClosureWrapper(controlEvent, action)
        closureWrapper[controlEvent.rawValue] = wrapperValue
        addTarget(wrapperValue, action: #selector(ControlClosureWrapper.actionExcute(_:)), for: controlEvent)
    }

    func removeEventAction(for controlEvent: UIControl.Event) {
        closureWrapper[controlEvent.rawValue] = nil
    }

    func addTouchupInsideAction(_ action: @escaping UIControl.Action) {
        addEventAction(for: .touchUpInside, action: action)
    }

    func removeTouchupInsideAction() {
        removeEventAction(for: .touchUpInside)
    }
}
