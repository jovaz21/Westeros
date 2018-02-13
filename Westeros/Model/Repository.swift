//
//  Repository.swift
//  Westeros
//
//  Created by ATEmobile on 13/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        return([])
    }
}
