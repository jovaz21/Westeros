//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    // Our nil-able variables
    var season1: Season!
    var season2: Season!

    // Init / Halt Tests
    override func setUp() { super.setUp()
        
        /* create */
        season1 = Season(name: "Temporada1", startDate: "2016-12-31")
        season1.add(episode: Episode(name: "Episode1", date: "2016-12-31"))
        season1.add(episode: Episode(name: "Episode2", date: "2017-01-31"))
        season1.add(episode: Episode(name: "Episode3", date: "2017-02-28"))
        season1.add(episode: Episode(name: "Episode4", date: "2017-03-31"))
        season1.add(episode: Episode(name: "Episode5", date: "2017-04-30"))
        season1.add(episode: Episode(name: "Episode6", date: "2017-05-31"))

        /* create */
        season2 = Season(name: "Temporada2", startDate: "2017-09-30")
        season2.add(episode: Episode(name: "Episode1", date: "2017-10-31"))
        season2.add(episode: Episode(name: "Episode2", date: "2017-11-30"))
        season2.add(episode: Episode(name: "Episode3", date: "2017-12-31"))
        season2.add(episode: Episode(name: "Episode4", date: "2018-01-31"))
        season2.add(episode: Episode(name: "Episode5", date: "2018-02-28"))
    }
    override func tearDown() { super.tearDown() }
    
    // Season
    func testSeasonInit() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    func testSeasonEquality() {
        
        // Identity
        XCTAssertEqual(season1, season1)

        // Unequality
        XCTAssertNotEqual(season1, season2)
    }
    func testSeasonHash() {
        XCTAssertNotNil(season1.hashValue)
    }
    func testSeasonIsAlphabeticallyOrdered() {
        XCTAssertLessThan(season1, season2)
    }
    func testSeasonSortedEpisodes() {
        
        // Init
        let sortedEpisodes = season1.sortedEpisodes
        XCTAssertNotNil(sortedEpisodes)
        
        // Order
        let firstEpisode: Episode = sortedEpisodes.first!
        let lastEpisode: Episode  = sortedEpisodes.last!
        XCTAssertEqual(firstEpisode.name, "Episode1")
        XCTAssertEqual(lastEpisode.name, "Episode6")
    }
    func testSeasonDescription() {
        XCTAssertEqual(season1.description, "Temporada1 - 2016-12-31 (\(season1.count))")
    }
    
    // Episodes
    func testAddEpisodes() {
        
        /* create */
        let season = Season(name: "Temporada3", startDate: "2019-01-01")
        XCTAssertEqual(season.count, 0)
        
        season.add(episode: Episode(name: "Episode1", date: "2019-01-01"))
        XCTAssertEqual(season.count, 1)

        XCTAssertEqual(season2.count, 5)
        season.add(episode: Episode(season: season2, name: "Episode6", date: "2018-03-31"))
        XCTAssertEqual(season.count, 1)
        XCTAssertEqual(season2.count, 6)
    }
    func testEpisodeDescription() {
        let episode = Episode(name: "Episodio7", date: "2017-06-30")
        XCTAssertEqual(episode.description, "Episodio7 (2017-06-30)")
        
        season1.add(episode: episode)
        XCTAssertEqual(episode.description, "Episodio7 (Temporada1 - 2017-06-30)")
    }
}
