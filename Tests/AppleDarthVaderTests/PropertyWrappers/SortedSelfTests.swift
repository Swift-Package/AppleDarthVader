//
//  SortedSelfTests.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2024/11/4.
//

@testable import AppleDarthVader
import Testing

struct Person {
    let firstName: String
    let lastName: String
    let age: Int
}

struct SortedSelfTests {
    @Test func test() {
        @SortedSelf(by: \.age) var people = [
            Person(firstName: "A", lastName: "A", age: 12),
            Person(firstName: "B", lastName: "B", age: 4),
            Person(firstName: "V", lastName: "V", age: 2),
            Person(firstName: "C", lastName: "C", age: 3),
        ]

        #expect(people.first?.age == 2)
        people.append(Person(firstName: "X", lastName: "X", age: 1))
        #expect(people.first?.age == 1)
    }
}
