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
    weak var    house:  House!
    let         name:   String
    var         alias:  String { return(_alias ?? "") }

    private let _alias: String?

    // Init
    init(name: String, alias: String? = nil, house: House? = nil) {
        
        /* set */
        self.name   = name
        self.house  = house
        
        /* set */
        _alias = alias
        
        /* check */
        if (house != nil) {
            house!.add(person: self)
        }
    }
}
extension Person {
    var fullName: String { return("\(name) \(house.name)"); }
}

// MARK: - Proxies
extension Person {
    var proxyForEquality:   String { return("\(name) \(alias) \(house.name)") }
    var proxyForComparison: String { return(fullName.uppercased()) }
}

// MARK: - Comparable
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return(lhs.proxyForComparison < rhs.proxyForComparison)
    }
}

// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int { return(proxyForEquality.hashValue) }
}

// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return(lhs.hashValue == rhs.hashValue)
    }
}
