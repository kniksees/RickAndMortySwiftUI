//
//  LocationsNetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import Foundation

class LocationsNetworkManager {
    
    static func getCountOfLocations() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/location")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Welcome.self, from: data).info.count
    }
    
    static func getLocation(num: Int) async -> Location {
        let url = URL(string: "https://rickandmortyapi.com/api/location/\(num)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Location.self, from: data)
    }
    
    class Welcome: Codable {
        let info: Info
        let results: [Location]
        
        init(info: Info, results: [Location]) {
            self.info = info
            self.results = results
        }
    }
    
    class Info: Codable {
        let count: Int
        let pages: Int
        
        init(count: Int, pages: Int) {
            self.count = count
            self.pages = pages
        }
    }
    
    class Location: Codable {
        let id: Int
        let name: String
        let type: String
        let dimension: String
        let residents: [String]
        let url: String
        let created: String
        
        init(id: Int, name: String, type: String, dimension: String, residents: [String], url: String, created: String) {
            self.id = id
            self.name = name
            self.type = type
            self.dimension = dimension
            self.residents = residents
            self.url = url
            self.created = created
        }
    }
}




