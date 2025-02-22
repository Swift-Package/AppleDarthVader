//
//  UITableViewExtensions.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReuseableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("无法通过重用标识 \(T.reuseIdentifier) 获得Cell")
        }
        return cell
    }

    /// 配合Realm数据库的enum RealmCollectionChange<CollectionType>使用
    /// - Parameters:
    ///   - deletions: 被删除的Index
    ///   - insertions: 新增的Index
    ///   - updates: 被更新的Index
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        beginUpdates()
        deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
        insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
        reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
        endUpdates()
    }
}

public extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        IndexPath(row: row, section: 0)
    }
}
