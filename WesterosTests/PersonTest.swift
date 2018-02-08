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
    var starkHouse: House!
    var ned: Person!
    var arya: Person!

    // Init / Halt Tests
    override func setUp() { super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
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
}
