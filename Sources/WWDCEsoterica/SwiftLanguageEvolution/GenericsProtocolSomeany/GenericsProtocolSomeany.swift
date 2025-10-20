//
//  GenericsProtocolSomeany.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

// MARK: - 教程来源
// WWDC22 - 采用S wift 泛型
// WWDC22 - 使用S wift 设计协议接口
// WWDC20 - 在 Swift 中设计协议接口 Design protocol interface in Swift
// WWDC23 - 使用参数包泛化 API

import Foundation

// MARK: - 简单谷仓泛型类
struct Silo<Material> {
    private var storage: [Material]
    
    init(storage materials: [Material]) {
        self.storage = materials
    }
}

// MARK: - 庄稼协议
fileprivate protocol Crop {
    associatedtype FeedType: AnimalFeed where FeedType.CropType == Self // 庄稼可以收获产生动物饲料 而动物饲料又来源于庄稼
    
    /// 庄稼可以收获产生动物饲料
    func harvest() -> FeedType
}

// MARK: - 动物饲料协议
fileprivate protocol AnimalFeed {
    associatedtype CropType: Crop where CropType.FeedType == Self // 动物饲料静态方法可以生成庄稼 而庄稼可以收获产生动物饲料
    
    /// 动物饲料静态方法可以生成庄稼
    static func grow() -> CropType
}

// MARK: - 苜蓿
fileprivate struct Alfalfa: Crop {
    func harvest() -> Hay {
        Hay()
    }
}

// MARK: - 干草
fileprivate struct Hay: AnimalFeed {
    static func grow() -> Alfalfa {
        Alfalfa()
    }
}


fileprivate protocol Animal {
    associatedtype FeedType: AnimalFeed     // 动物吃不同的饲料
    // associatedtype Habitat
    
    func eat(_ food: FeedType)
}

fileprivate struct Cow: Animal {
    func eat(_ food: Hay) {}
}

// MARK: - 农场
fileprivate struct Farm {
    
    func feed(_ animal: some Animal) {
        let crop = type(of: animal).FeedType.grow()
        let produce = crop.harvest()
        animal.eat(produce)
    }
    
    func feedAll(_ animals: [any Animal]) {
        for animal in animals {
            feed(animal)
        }
    }
    
    // func buildHome<A>(for animal: A) -> A.Habitat where A: Animal { }
}

