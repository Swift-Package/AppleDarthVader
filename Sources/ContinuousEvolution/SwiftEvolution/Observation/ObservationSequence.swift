//
//  File.swift
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/12/19.
//

// https://github.com/swiftlang/swift-evolution/blob/main/proposals/0475-observed.md

import UIKit
import SwiftUI
import Observation

@Observable
fileprivate class Person1 {
	
	var firstName: String
	var lastName: String
	
	var name: String { firstName + " " + lastName } 
	
	init(firstName: String, lastName: String) { 
		self.firstName = firstName
		self.lastName = lastName 
	}
}

fileprivate class ViewController: UIViewController {
	
	let person = Person1(firstName: "AA", lastName: "BB")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let names = Observations { self.person.firstName }
		
		Task.detached {
			for await name in names {
				print("Task1: \(name)")
			}
		}
		
		Task.detached {
			for await name in names {
				print("Task2: \(name)")
			}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
			guard let self else { return }
			person.firstName = "CC"
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
			guard let self else { return }
			person.firstName = "DD"
		}
	}
}

#Preview { 
	ViewController()
}
