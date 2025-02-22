//
//  RxUIViewControllerAlert.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

// 该RxSwift扩展来自kodeco网站 - RxSwift书籍教程项目 Combinestagram

import RxSwift
import UIKit

extension UIViewController {
    func alert(title: String, text: String?) -> Completable {
        return Completable.create { [weak self] completable in
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                completable(.completed)
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

/* alert(title: "未授权", text: "请重新授权")
 .asObservable()
 .take(.seconds(5), scheduler: MainScheduler.instance)// 5秒后自动关闭
 .subscribe()
 .disposed(by: bag) */
