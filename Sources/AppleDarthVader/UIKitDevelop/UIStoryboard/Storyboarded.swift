//
//  Storyboarded.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

// https://www.youtube.com/watch?v=7HgbcTqxoN4

public protocol Storyboarded {
    static func instantiate() -> Self
}

// 依赖于Storyboard中的控制器的ID也设置为类名
@MainActor
public extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}

// https://www.raywenderlich.com/158-coordinator-tutorial-for-ios-getting-started#ratings-count-hook

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype UIViewControllerType

    static var defaultFileName: String { get }

    static func instantiateViewController(_ bundle: Bundle?) -> UIViewControllerType
}

@MainActor
public extension StoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String { NSStringFromClass(Self.self).components(separatedBy: ".").last! }

    static func instantiateViewController(_ bundle: Bundle?) -> Self {
        UIStoryboard(name: defaultFileName, bundle: bundle).instantiateInitialViewController() as! Self
    }
}
