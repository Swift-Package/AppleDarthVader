//
//  ConfigurationUpdateHandler.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/23.
//

// WWDC 26 - UIKit 的新功能

import UIKit
import SwiftUI
import Observation

@Observable
fileprivate class ListItemModel {
    var icon: UIImage
    var title: String
    var subtitle: String
    
    init(icon: UIImage, title: String, subtitle: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
    }
}

fileprivate class ViewController: UIViewController, UICollectionViewDataSource {
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var listItems: [ListItemModel] = [
        .init(icon: .init(systemName: "heart")!, title: "heart", subtitle: "heart"),
            .init(icon: .init(systemName: "star")!, title: "star", subtitle: "star"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.listItems[0].icon = .init(systemName: "circle")!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let item = listItems[indexPath.item]
        cell.configurationUpdateHandler = { cell, state in
            var content = UIListContentConfiguration.subtitleCell()
            content.image = item.icon
            content.text = item.title
            content.textProperties.color = .red
            content.secondaryText = item.subtitle
            cell.contentConfiguration = content
        }
        return cell
    }
}

#Preview {
    Button("点击查看效果") {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            if #available(iOS 26.0, *) {
                window.rootViewController = UINavigationController(rootViewController: ViewController())
            } else {
                // Fallback on earlier versions
            }
            window.makeKeyAndVisible()
        }
    }
}
