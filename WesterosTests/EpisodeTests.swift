//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    // Our nil-able variables
    var episode1: Episode!
    var episode2: Episode!

    // Init / Halt Tests
    override func setUp() {
        episode1 = Episode(name: "Episodio1", date: "2016-12-31")
        episode2 = Episode(name: "Episodio2", date: "2017-01-31")
    }
    override func tearDown() {}
    
    // Episode
    func testEpisodeInit() {
        
        // Not Nil
        XCTAssertNotNil(episode1)
        
        // Season is Nil
        XCTAssertNil(episode1.season)
    }
    func testEpisodeEquality() {
        
        // Identity
        XCTAssertEqual(episode1, episode1)
        
        // Unequality
        XCTAssertNotEqual(episode1, episode2)
    }
    func testEpisodeDescription() {
        XCTAssertEqual(episode1.description, "Episodio1 (2016-12-31)")
    }
}
