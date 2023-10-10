//
//  Storege.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 05.10.2023.
//

import Foundation
import SwiftData

class Storege {
    @Model
    final class Location {
        var id: UUID = UUID()
        @Attribute(.unique) var identificator: Int
        var name: String
        var type: String
        var dimension: String
        var residents: [Int]
        var url: String
        var created: String
        
        init(location: LocationsNetworkManager.Location) {
            self.identificator = location.id
            self.name = location.name
            self.type = location.type
            self.dimension = location.dimension
            self.residents = Formarters.URLArrayToIdArray(urls: location.residents) 
            self.url = location.url
            self.created = location.created
        }
    }
    
    @Model
    final class Person {
        var id: UUID = UUID()
        @Attribute(.unique) var identificator: Int
        var name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: Int?
        let location: Int?
        let image: Data
        let episode: [Int]
        let url: String
        let created: String
        
        init(person: PersonsNetworkManager.PersonInfo, imageData: Data) {
            self.identificator = person.id
            self.name = person.name
            self.status = person.status
            self.species = person.species
            self.type = person.type
            self.gender = person.gender
            if person.origin.url.count != 0 {
                self.origin = Formarters.URLToId(url: person.origin.url)
            }
            if person.location.url.count != 0 {
                self.location = Formarters.URLToId(url: person.location.url)
            }
            self.image = imageData
            self.episode = Formarters.URLArrayToIdArray(urls: person.episode)
            self.url = person.url
            self.created = person.created
        }
    }
    
    @Model
    final class Episode {
        let id = UUID()
        @Attribute(.unique) let identificator: Int
        let name: String
        let air_date: String
        let episode: String
        let characters: [Int]
        let url: String
        let created: String
        
        init(episode: EpisodesNetworkManager.Episode) {
            self.identificator = episode.id
            self.name = episode.name
            self.air_date = episode.air_date
            self.episode = episode.episode
            self.characters = Formarters.URLArrayToIdArray(urls: episode.characters)
            self.url = episode.url
            self.created = episode.created
        }
    }
}




