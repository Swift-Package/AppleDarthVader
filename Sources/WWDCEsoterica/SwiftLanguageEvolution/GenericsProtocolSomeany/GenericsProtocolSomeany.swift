//
//  GenericsProtocolSomeany.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

// MARK: - 教程来源

// WWDC22 - 采用Swift泛型
// WWDC22 - 使用Swift设计协议接口
// WWDC20 - 在Swift中设计协议接口 Design protocol interface in Swift
// WWDC23 - 使用参数包泛化API

import Foundation

// MARK: - 简单谷仓泛型类

struct Silo<Material> {
    private var storage: [Material]

    init(storage materials: [Material]) {
        storage = materials
    }
}

// MARK: - 庄稼协议

private protocol Crop {
    associatedtype FeedType: AnimalFeed where FeedType.CropType == Self // 庄稼可以收获产生动物饲料 而动物饲料又来源于庄稼

    /// 庄稼可以收获产生动物饲料
    func harvest() -> FeedType
}

// MARK: - 动物饲料协议

private protocol AnimalFeed {
    associatedtype CropType: Crop where CropType.FeedType == Self // 动物饲料静态方法可以生成庄稼 而庄稼可以收获产生动物饲料

    /// 动物饲料静态方法可以生成庄稼
    static func grow() -> CropType
}

// MARK: - 苜蓿

private struct Alfalfa: Crop {
    func harvest() -> Hay {
        Hay()
    }
}

// MARK: - 干草

private struct Hay: AnimalFeed {
    static func grow() -> Alfalfa {
        Alfalfa()
    }
}

private protocol Animal {
    associatedtype FeedType: AnimalFeed // 动物吃不同的饲料
    // associatedtype Habitat

    func eat(_ food: FeedType)
}

private struct Cow: Animal {
    func eat(_: Hay) {}
}

// MARK: - 农场

private struct Farm {
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
