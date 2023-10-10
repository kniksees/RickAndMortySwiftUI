//
//  RickAndMortySwiftUIApp.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 05.10.2023.
//

import SwiftUI
import SwiftData

@main
struct RickAndMortySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .modelContainer(for: [Storege.Location.self, Storege.Person.self, Storege.Episode.self]
                                //, inMemory: true
                                , isAutosaveEnabled: true)
        }
    }
}
