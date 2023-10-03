//
//  LocationsNetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import Foundation


class LocationsNetworkManager {
    
    static func getCountOfCharecters() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/location")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Welcome.self, from: data).info.count
    }
    
    static func getCountOfPages() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/location")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Welcome.self, from: data).info.pages
    }
    
    static func getLocations(num: Int) async -> [Location] {
        let url = URL(string: "https://rickandmortyapi.com/api/location?page=\(num)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Welcome.self, from: data).results
    }
    
    static func getLocation(url: String) async -> LocationInfo {
        let url = URL(string: url)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(LocationInfo.self, from: data)
    }
    
    struct Welcome: Codable {
        let info: Info
        let results: [Location]
    }
    
    struct Info: Codable {
        let count: Int
        let pages: Int
    }
    
    struct Location: Codable {
        let id: Int
        let name: String
        let type: String
        let dimension: String
        let residents: [String]
        let url: String
        let created: String
    }
    
    struct LocationInfo: Codable {
        let id: Int
        let name, type, dimension: String
        let residents: [String]
        let url: String
        let created: String
    }

    
}


