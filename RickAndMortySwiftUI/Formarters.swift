//
//  DateFormarters.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 01.10.2023.
//

import Foundation

class Formarters {
    static func episodeNumberFormater(episode: String) -> String {
        let arr = Array(episode)
        return "Episode: \(Int(String(arr[4...5]))!), Season: \(Int(String(arr[1...2]))!)"
    }
    
    static func URLToId (url: String) -> Int {
        Int(url.split(separator: "/").last!)!
    }
    
    static func URLArrayToIdArray (urls: [String]) -> [Int] {
        var res = [Int]()
        for i in urls {
            res.append(URLToId(url: i)) 
        }
        return res
    }
}
