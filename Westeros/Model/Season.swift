//
//  Season.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

// MARK: - Season
final class Season {
    private var _episodes:  Episodes
    let         name:       String
    let         startDate:  Date
    
    // Init
    init(name: String, startDate startDateStr: String) {
        
        /* set */
        self.name       = name
        self.startDate  = Date.fromString(startDateStr)!
        
        /* set */
        _episodes = Episodes()
    }
}

// MARK: - Season Episodes Stuff
extension Season {
    var count:          Int         { return(_episodes.count) }
    var sortedEpisodes: [Episode]   { return(_episodes.sorted()) }
    
    // Add Episode
    func add(episode: Episode) {
        guard ((episode.season == nil) || (episode.season == self)) else {
            return;
        }
        
        /* set */
        episode.season = self
        
        /* insert */
        _episodes.insert(episode)
    }
    
    // Add Episodes
    func add(episodes: Episode...) { episodes.forEach { add(episode: $0) } }
}

// MARK: - Proxies
extension Season {
    var proxyForEquality: String {
        return("\(name) \(startDate) \(count)")
    }
    var proxyForComparison: String {
        return(name.uppercased())
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return(lhs.proxyForComparison < rhs.proxyForComparison)
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return(proxyForEquality.hashValue)
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return(lhs.proxyForEquality == rhs.proxyForEquality)
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        let startDateStr = startDate.toString()
        
        /* done */
        return("\(name) - \(startDateStr) (\(count))")
    }
}
