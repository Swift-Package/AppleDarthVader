//
//  GenericsProtocolOpaque.swift
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

// MARK: - ⚠️where是为了双向绑定两个符合协议的具体类型相互关联 为了防止出现干草收获到小米的错误

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

// MARK: - 干草
fileprivate struct Hay: AnimalFeed {
    static func grow() -> Alfalfa {
        Alfalfa()
    }
}

// MARK: - 苜蓿
fileprivate struct Alfalfa: Crop {
    func harvest() -> Hay {
        Hay()
    }
}

// MARK: - 鸡饲料
struct Scratch: AnimalFeed {
    static func grow() -> Millet {
        Millet()
    }
}

// MARK: - 小米庄稼
struct Millet: Crop {
    func harvest() -> Scratch {
        Scratch()
    }
}


fileprivate protocol Animal {
    associatedtype FeedType: AnimalFeed // 动物吃不同的饲料
    associatedtype CommodityType: Food  // 动物提供给人类不同的食物
    
    var isHungry: Bool { get }
    
    func eat(_ food: FeedType)
    
    func produce() -> CommodityType
}

fileprivate struct Cow: Animal {
    
    var isHungry: Bool { true }
    
    func eat(_ food: Hay) {}
    
    func produce() -> Milk {
        Milk()
    }
}
struct Chicken: Animal {
    
    var isHungry: Bool { true }
    
    func eat(_ food: Scratch) {
        
    }
    
    func produce() -> Egg {
        Egg()
    }
}


// MARK: - 农场
fileprivate struct Farm {
    
    var animals: [any Animal]
    
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
    
    func produceCommodities() -> [any Food] {
        animals.map { animal in
            animal.produce()
        }
    }
    
    // func buildHome<A>(for animal: A) -> A.Habitat where A: Animal { }
}

extension Farm {
    
    var isLazy: Bool {
        Bool.random()
    }
    
    var hungryAnimals: LazyFilterSequence<[any Animal]> {// 1这种方法会暴露实现细节
        animals.lazy.filter(\.isHungry)
    }
    
    var someHungryAnimals: some Collection {// 2这种方法不会暴露实现细节但是隐藏太多了
        animals.lazy.filter(\.isHungry)
    }
    
    var anyHungryAnimals: some Collection<any Animal> {// 3这种方法恰到好处
        animals.lazy.filter(\.isHungry)
    }
    
    var optionalLazyAnyHungryAnimals: any Collection<any Animal> {// 4还有这种方法
        if isLazy {
            animals.lazy.filter(\.isHungry)
        } else {
            animals.filter(\.isHungry)
        }
    }
    
    func feedAnimals() {
        for animal in anyHungryAnimals {// 因为hungryAnimals迭代一次完就丢弃了所以使用lazy避免临时分配内存
            feedAnimal(animal)
        }
    }
    
    private func feedAnimal(_ animal: some Animal) {
        let crop = type(of: animal).FeedType.grow()
        let feed = crop.harvest()
        animal.eat(feed)
    }
}

fileprivate protocol Food {
    
}

struct Milk: Food {
    
}

struct Egg: Food {
    
}

func test() {
    let cow = Cow()
    let alfalfa = Hay.grow()
    let hay = alfalfa.harvest()
    cow.eat(hay)
    
    let chicken = Chicken()
    let millet = Scratch.grow()
    let scratch = millet.harvest()
    chicken.eat(scratch)
}


