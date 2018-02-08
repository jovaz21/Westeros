//
//  Character.swift
//  Westeros
//
//  Created by ATEmobile on 8/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import Foundation

// Person
final class Person {
    let name: String
    let house: House
    var alias: String { return(_alias ?? "") }

    private let _alias: String?
    
    // Init
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self.house = house
        _alias = alias
    }
}

extension Person {
    var fullName: String {
        return("\(name) \(house.name)");
    }
}

// MARK: - Proxies
extension Person {
    var proxy: String {
        return("\(name) \(alias) \(house.name)")
    }
}

// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return(proxy.hashValue)
    }
}

// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return(lhs.hashValue == rhs.hashValue)
    }
}








