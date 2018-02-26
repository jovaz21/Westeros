//
//  House.swift
//  Westeros
//
//  Created by ATEmobile on 8/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person>

// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    
    private var _members: Members
    
    // Init
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        
        /* set */
        self.name       = name
        self.sigil      = sigil
        self.words      = words
        self.wikiURL    = url
        
        /* set */
        _members = Members()
    }
}

// MARK: - House Members Stuff
extension House {
    var count:          Int         { return(_members.count) }
    var sortedMembers:  [Person]    { return(_members.sorted()) }
    
    // Add Person
    func add(person: Person) {
        guard ((person.house == nil) || (person.house == self)) else {
            return;
        }
        
        /* set */
        person.house = self
        
        /* insert */
        _members.insert(person)
    }
    
    // Add Persons
    func add(persons: Person...) { persons.forEach { add(person: $0) } }
}

// MARK: - Proxies
extension House {
    var proxyForEquality:   String { return("\(name) \(words) \(count)") }
    var proxyForComparison: String { return(name.uppercased()) }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return(lhs.proxyForComparison < rhs.proxyForComparison)
    }
}

// MARK: - Hashable
extension House: Hashable {
    var hashValue: Int { return(proxyForEquality.hashValue) }
}

// MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return(lhs.proxyForEquality == rhs.proxyForEquality)
    }
}

// MARK: - Sigil
final class Sigil {
    let image: UIImage
    let description: String

    // Init
    init(image: UIImage, description: String) {
        self.image          = image
        self.description    = description
    }
}
