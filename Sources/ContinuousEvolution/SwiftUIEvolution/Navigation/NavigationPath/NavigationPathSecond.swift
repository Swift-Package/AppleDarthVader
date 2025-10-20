//
//  NavigationPathSecond.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/10/18.
//

import SwiftUI

// 教程来源 - https://www.youtube.com/watch?v=ZQXzZ1hxQwo

import SwiftUI

// MARK: - 汽车品牌
fileprivate struct CarBrand: Identifiable, Hashable {
    
    let id = UUID()
    let name: String
    
    static let brands = [
        CarBrand(name: "Ferrari"),
        CarBrand(name: "Lamborghini"),
        CarBrand(name: "Mercedes"),
        CarBrand(name: "Aston Martin")
    ]
}

// MARK: - 汽车车型
fileprivate struct Car: Identifiable, Hashable {
    
    let id = UUID()
    let name: String
    
    static let cars = [
        Car(name: "FC40"),
        Car(name: "Aventador"),
        Car(name: "Vantage"),
        Car(name: "AMG S63")
    ]
}

fileprivate struct NavigationPathSecond: View {
    
    @State private var navigationPath: [CarBrand] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturerers") {
                        ForEach(CarBrand.brands) { brand in
                            NavigationLink(value: brand) {
                                Text(brand.name)
                            }
                        }
                    }
                    
                    Section("Cars") {
                        ForEach(Car.cars) { car in
                            NavigationLink(value: car) {
                                Text(car.name)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { carBrand in
                    viewForBrand(carBrand)
                }
                .navigationDestination(for: Car.self) { car in
                    Text(car.name)
                }
            }
            Button {
                navigationPath = CarBrand.brands
            } label: {
                Text("View ALl")
            }

        }
    }
}

fileprivate extension NavigationPathSecond {
    func viewForBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
        case "Ferrari":
            return AnyView(Text("Ferrari"))
        case "Lamborghini":
            return AnyView(Text("Lamborghini"))
        case "Mercedes":
            return AnyView(Text("Mercedes"))
        case "Aston Martin":
            return AnyView(Text("Aston Martin"))
        default:
            return AnyView(Text("default"))
        }
    }
}

#Preview {
    NavigationPathSecond()
}
