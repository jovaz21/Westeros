//
//  Episode.swift
//  Westeros
//
//  Created by ATEmobile on 18/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import Foundation

// Episode
final class Episode {
    weak var    season:  Season!
    let         name:   String
    let         date:   Date
    
    // Init
    init(season: Season? = nil, name: String, date dateStr: String) {
        
        /* set */
        self.season = season
        self.name   = name
        self.date   = Date.fromString(dateStr)!
        
        /* check */
        if (season != nil) {
            season!.add(episode: self)
        }
    }
}

// MARK: - Proxies
extension Episode {
    var proxyForEquality:   String { return("\(name) \(date)") }
    var proxyForComparison: String { return(name.uppercased()) }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return(lhs.proxyForComparison < rhs.proxyForComparison)
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int { return(proxyForEquality.hashValue) }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return(lhs.proxyForEquality == rhs.proxyForEquality)
    }
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        let dateStr = date.toString()
        
        /* check */
        if (season == nil) {
            return("\(name) (\(dateStr))")
        }
        
        /* done */
        return("\(name) (\(season.name) - \(dateStr))")
    }
}
