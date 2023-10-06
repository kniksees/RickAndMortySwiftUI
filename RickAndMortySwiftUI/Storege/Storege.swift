//
//  Storege.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 05.10.2023.
//

import Foundation
import SwiftData

@Model
final class Location {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
    init(location: LocationsNetworkManager.Location) {
        self.id = location.id
        self.name = location.name
        self.type = location.type
        self.dimension = location.dimension
        self.residents = location.residents
        self.url = location.url
        self.created = location.created
    }
}
