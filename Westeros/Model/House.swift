//
//  House.swift
//  Westeros
//
//  Created by ATEmobile on 8/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

typealias Words = String

// House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
    }
}

// Sigil
final class Sigil {
    let image: UIImage
    let description: String

    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}
