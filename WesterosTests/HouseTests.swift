//
//  HouseTests.swift
//  WesterosTests
//
//  Created by ATEmobile on 8/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    // Our nil-able variables
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    var starkHouse: House!
    var lannisterHouse: House!
    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    // Init / Halt Tests
    override func setUp() { super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }
    override func tearDown() { super.tearDown() }
    
    // House
    func testHouseInit() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    // Sigil
    func testSigilInit() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    // Persons
    func testAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)

        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
}




