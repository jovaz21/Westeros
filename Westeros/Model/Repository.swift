//
//  Repository.swift
//  Westeros
//
//  Created by ATEmobile on 13/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    var houses: [House] { get }
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "León rampante")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        
        starkHouse.add(person: arya);
        starkHouse.add(person: robb);
        lannisterHouse.add(person: tyrion);
        
        return([starkHouse, lannisterHouse])
    }
}
