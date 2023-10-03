//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 01.10.2023.
//


import Foundation


class CharactersNetworkManager {

    static func getCountOfCharecters() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Response.self, from: data).info.count
    }
    
    static func getCountOfPages() async -> Int {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Response.self, from: data).info.pages
    }
    
    
    static func makeResponse(num: Int) async -> [Person] {
        let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(num)")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Response.self, from: data).results
    }

    static func getDataByURL(apiURL: String) async -> Data {
        let url = URL(string: apiURL)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return data
    }
    
    static func getPersonInfo(strUrl: String) async -> PersonInfo {
        let url = URL(string: strUrl)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(PersonInfo.self, from: data)
    }
    
    static func getPlanet(strUrl: String) async -> Planet {
        let url = URL(string: strUrl)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(Planet.self, from: data)
    }
    
    static func getEpisodes(strUrl: [String]) async -> [Episode] {
        var episodes = [Episode]()
        for i in strUrl {
            let url = URL(string: i)!
            let (data, _) = try! await URLSession.shared.data(from: url)
            episodes.append(try! JSONDecoder().decode(Episode.self, from: data))
        }
        return episodes
    }
    
    struct Response: Decodable {
        var info: Info
        var results: [Person]
    }

    struct Info: Decodable {
        var count: Int
        var pages: Int
        var next: String?
        var prev: String?
    }

    struct Person: Decodable {
        var id: Int
        var name: String
        var status: String
        var species: String
        var type: String
        var gender: String
        var origin: Location
        var location: Location
        var image: String
        var episode: [String]
        var url: String
        var created: String
    }

    struct Location: Decodable {
        var name: String
        var url: String
    }

    struct PersonInfo: Decodable {
        let id: Int
        let name, status, species, type: String
        let gender: String
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }

    struct Planet: Decodable {
        let id: Int
        let name, type, dimension: String
        let residents: [String]
        let url: String
        let created: String
    }


    struct Episode: Decodable {
        let name: String
        let air_date: String
        let episode: String
        let url: String
    }
}



