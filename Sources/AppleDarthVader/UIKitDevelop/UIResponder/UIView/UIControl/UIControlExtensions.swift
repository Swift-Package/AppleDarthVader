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
    private static var ControlClosureAssociatedKey = "ControlClosureAssociatedKey"

    private var closureWrapper: [UInt: ControlClosureWrapper] {
        get {
            if let wrapper = objc_getAssociatedObject(self, &UIControl.ControlClosureAssociatedKey) as? [UInt: ControlClosureWrapper] {
                return wrapper
            } else {
                let wrapper = [UInt: ControlClosureWrapper]()
                self.closureWrapper = wrapper
                return wrapper
            }
        }
        set {
            objc_setAssociatedObject(self, &UIControl.ControlClosureAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    typealias Action = (_ sender: UIControl) -> Void

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
