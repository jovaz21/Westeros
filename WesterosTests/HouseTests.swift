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
    
    // Init / Halt Tests
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    // House
    func testHouseInit() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        let stark = House(name: "Starck", sigil: starkSigil, words: "Se acerca el invierno")
        XCTAssertNotNil(stark)
    }
    
    // Sigil
    func testSigilInit() {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        XCTAssertNotNil(starkSigil)

        let lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        XCTAssertNotNil(lannisterSigil)
    }
}
