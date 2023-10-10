//
//  LocationsNetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 03.10.2023.
//

import Foundation

class EpisodesNetworkManager {
    
    static func getCountOfEpisodes() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/episode")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Welcome.self, from: data).info.count
    }
    
    static func getEpisodes(id: Int) async -> Episode {
        let url = URL(string: "https://rickandmortyapi.com/api/episode/\(id)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Episode.self, from: data)
    }
    
    class Welcome: Decodable {
        let info: Info
        let results: [Episode]
        
        init(info: Info, results: [Episode]) {
            self.info = info
            self.results = results
        }
    }
    
    class Info: Decodable {
        let count, pages: Int
        
        init(count: Int, pages: Int) {
            self.count = count
            self.pages = pages
        }
    }
    
    class Episode: Decodable {
        let id: Int
        let name: String
        let air_date: String
        let episode: String
        let characters: [String]
        let url: String
        let created: String
        
        init(id: Int, name: String, air_date: String, episode: String, characters: [String], url: String, created: String) {
            self.id = id
            self.name = name
            self.air_date = air_date
            self.episode = episode
            self.characters = characters
            self.url = url
            self.created = created
        }
    }
}
