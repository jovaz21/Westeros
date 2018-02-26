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
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    // Init / Halt Tests
    override func setUp() { super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    override func tearDown() { super.tearDown() }
    
    // Test Creation
    func testLocalRepositoryCreation() {
        let repo = Repository.local
        XCTAssertNotNil(repo)
    }
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    // Test Local Repo Returns Sorted Arrays
    func testLocalRepositorySortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    func testLocalRepositorySortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositoryReturnHousesByCaseInsensitiveName() {
        var stark = Repository.local.house(named: "sTaRk")
        XCTAssertEqual(stark?.name, "Stark")

        stark = Repository.local.house(named: .Stark)
        XCTAssertEqual(stark?.name, "Stark")

        let keepCoding = Repository.local.house(named: "KeepCoding")
        XCTAssertNil(keepCoding)
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        for each in filtered {
            XCTAssertEqual(each.count, 1)
        }
    }
    func testSeasonFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.count == 2 })
        for each in filtered {
            XCTAssertEqual(each.count, 2)
        }
    }
}
