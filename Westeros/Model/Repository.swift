//
//  Repository.swift
//  Westeros
//
//  Created by ATEmobile on 13/2/18.
//  Copyright © 2018 ATEmobile. All rights reserved.
//

import UIKit

final class Repository {
    static let local: WesterosModelFactory = LocalFactory()
    private init() {}
}

enum HouseName: String {
    case Stark
    case Lannister
    case Targaryen
}
protocol WesterosModelFactory {
    typealias Filter<Entity> = (Entity) -> Bool

    var seasons: [Season] { get }
    func seasons(filteredBy: Filter<Season>) -> [Season]

    var houses: [House] { get }
    func house1(named: String) -> House?
    func house(named: HouseName) -> House? // RESPUESTA A LA 8!!!
    func houses(filteredBy: Filter<House>) -> [House]
}

final class LocalFactory: WesterosModelFactory {
    var seasons: [Season] {

        /* create */
        let season1 = Season(name: "Temporada1", startDate: "2016-12-31")
            season1.add(episode: Episode(name: "Episodio1", date: "2016-12-31"))
            season1.add(episode: Episode(name: "Episodio2", date: "2017-01-31"))

        /* create */
        let season2 = Season(name: "Temporada2", startDate: "2017-12-31")
        season2.add(episode: Episode(name: "Episodio1", date: "2017-12-31"))
        season2.add(episode: Episode(name: "Episodio2", date: "2018-01-31"))

        /* create */
        let season3 = Season(name: "Temporada3", startDate: "2018-12-31")
        season3.add(episode: Episode(name: "Episodio1", date: "2018-12-31"))
        season3.add(episode: Episode(name: "Episodio2", date: "2019-01-31"))

        /* create */
        let season4 = Season(name: "Temporada4", startDate: "2019-12-31")
        season4.add(episode: Episode(name: "Episodio1", date: "2019-12-31"))
        season4.add(episode: Episode(name: "Episodio2", date: "2020-01-31"))
        season4.add(episode: Episode(name: "Episodio3", date: "2020-02-28"))

        /* create */
        let season5 = Season(name: "Temporada5", startDate: "2020-12-31")
        season5.add(episode: Episode(name: "Episodio1", date: "2020-12-31"))
        season5.add(episode: Episode(name: "Episodio2", date: "2021-01-31"))

        /* create */
        let season6 = Season(name: "Temporada6", startDate: "2021-12-31")
        season6.add(episode: Episode(name: "Episodio1", date: "2021-12-31"))
        season6.add(episode: Episode(name: "Episodio2", date: "2022-01-31"))

        /* create */
        let season7 = Season(name: "Temporada7", startDate: "2022-12-31")
        season7.add(episode: Episode(name: "Episodio1", date: "2022-12-31"))
        season7.add(episode: Episode(name: "Episodio2", date: "2023-01-31"))

        /* done */
        return([season1,season2,season3,season4,season5,season6,season7].sorted())
    }
    func seasons(filteredBy filterFn: Filter<Season>) -> [Season] {
        return(seasons.filter(filterFn))
    }
    
    var houses: [House] {
        
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)

        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)

        starkHouse.add(persons: arya, robb);
        lannisterHouse.add(persons: tyrion, cersei, jaime);
        targaryenHouse.add(persons: dani);
        
        return([starkHouse, lannisterHouse, targaryenHouse].sorted())
    }
    
    func house1(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        return(house)
    }
    func house(named name: HouseName) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.rawValue.uppercased() }.first
        return(house)
    }
    
    func houses(filteredBy filterFn: Filter<House>) -> [House] {
        return(houses.filter(filterFn))
    }
}
