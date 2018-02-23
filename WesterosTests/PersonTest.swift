//
//  CharacterTest.swift
//  WesterosTests
//
//  Created by ATEmobile on 8/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import XCTest
@testable import Westeros

class CharacterTest: XCTestCase {
    
    // Our nil-able variables
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    var starkHouse: House!
    var lannisterHouse: House!
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    var ned: Person!

    // Init / Halt Tests
    override func setUp() { super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")

        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
                
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
    }
    override func tearDown() { super.tearDown() }
    
    // Person
    func testPersonInit() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
    func testPersonEquality() {
        
        // Identity
        XCTAssertEqual(tyrion, tyrion)
        
        // Equality
        let enano = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        XCTAssertEqual(enano, tyrion)
        
        // Unequality
        XCTAssertNotEqual(tyrion, arya)
    }
}
