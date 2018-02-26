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
    var targaryenSigil: Sigil!
    var starkHouse: House!
    var lannisterHouse: House!
    var targaryenHouse: House!
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    var cersei: Person!
    var jaime: Person!
    var dani: Person!

    // Init / Halt Tests
    override func setUp() { super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        cersei = Person(name: "Cersei", house: lannisterHouse)
        jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
    }
    override func tearDown() { super.tearDown() }
    
    // House
    func testHouseInit() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    func testHouseEquality() {
        
        // Identity
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Equality
        let stark = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        let robb2 = Person(name: "Robb", alias: "El Joven Lobo", house: stark)
        let arya2 = Person(name: "Arya", house: stark)
        stark.add(persons: robb2, arya2)
        XCTAssertEqual(starkHouse, stark)

        // Unequality
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    func testHouseHash() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    func testHouseIsAlphabeticallyOrdered() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    func testHouseSortedMembers() {
        
        // Init
        starkHouse.add(persons: arya, robb);
        let sortedMembers = starkHouse.sortedMembers
        XCTAssertNotNil(sortedMembers)
        
        // Order
        let firstPerson: Person = sortedMembers.first!
        let lastPerson: Person  = sortedMembers.last!
        XCTAssertEqual(firstPerson.name, "Arya")
        XCTAssertEqual(lastPerson.name, "Robb")
    }
    
    // Sigil
    func testSigilInit() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    // Persons
    func testAddPersons() {
        XCTAssertEqual(starkHouse.count, 2)

        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
        
        lannisterHouse.add(persons: robb, tyrion, cersei, jaime)
        XCTAssertEqual(lannisterHouse.count, 3)
    }
}




