//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by ATEmobile on 13/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    // Init / Halt Tests
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testLocalRepositoryCreation() {
        let repo = Repository.local
        XCTAssertNotNil(repo)
    }
    func testLocalRepositoryHousesCreation() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
        XCTAssertEqual(houses.count, 2)
    }
}
