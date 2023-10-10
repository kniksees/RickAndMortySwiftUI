//
//  NetworkManager.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 08.10.2023.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class StorageManager {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func getEpisode(id: Int) -> Storege.Episode {
        let predicate = #Predicate<Storege.Episode> {
            $0.identificator == id
        }
        let descriptor = FetchDescriptor<Storege.Episode>(predicate: predicate)
        let episode = (try! modelContext.fetch(descriptor)).first!
        return episode
    }
    
    public func getEpisodes(setOfId: [Int]) -> [Storege.Episode] {
        let predicate = #Predicate<Storege.Episode> {
            setOfId.contains($0.identificator)
        }
        let descriptor = FetchDescriptor<Storege.Episode>(predicate: predicate)
        let episodes = (try! modelContext.fetch(descriptor))
        return episodes.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func getEpisodes() -> [Storege.Episode] {
        let predicate = #Predicate<Storege.Episode> { _ in
            true
        }
        let descriptor = FetchDescriptor<Storege.Episode>(predicate: predicate)
        let episodes = (try! modelContext.fetch(descriptor))
        return episodes.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func getPerson(id: Int) -> Storege.Person {
        let predicate = #Predicate<Storege.Person> {
            $0.identificator == id
        }
        let descriptor = FetchDescriptor<Storege.Person>(predicate: predicate)
        let person = (try! modelContext.fetch(descriptor)).first!
        return person
    }
    
    public func getPersons(setOfId: [Int]) -> [Storege.Person] {
        let predicate = #Predicate<Storege.Person> {
            setOfId.contains($0.identificator)
        }
        let descriptor = FetchDescriptor<Storege.Person>(predicate: predicate)
        let persons = (try! modelContext.fetch(descriptor))
        return persons.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func getPersons() -> [Storege.Person] {
        let predicate = #Predicate<Storege.Person> { _ in
            true
        }
        let descriptor = FetchDescriptor<Storege.Person>(predicate: predicate)
        let persons = (try! modelContext.fetch(descriptor))
        return persons.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func getLocation(id: Int?) -> Storege.Location? {
        if id == nil {
            return nil
        }
        let predicate = #Predicate<Storege.Location> {
            $0.identificator == id!
        }
        let descriptor = FetchDescriptor<Storege.Location>(predicate: predicate)
        let location = (try! modelContext.fetch(descriptor)).first
        return location
    }
    
    public func getLocations(setOfId: [Int]) -> [Storege.Location] {
        let predicate = #Predicate<Storege.Location> {
            setOfId.contains($0.identificator)
        }
        let descriptor = FetchDescriptor<Storege.Location>(predicate: predicate)
        let locations = (try! modelContext.fetch(descriptor))
        return locations.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func getLocations() -> [Storege.Location] {
        let predicate = #Predicate<Storege.Location> { _ in
            true
        }
        let descriptor = FetchDescriptor<Storege.Location>(predicate: predicate)
        let locations = (try! modelContext.fetch(descriptor))
        return locations.sorted(by: {$0.identificator < $1.identificator})
    }
    
    public func requestLocations(locationsCount: Int) {
        Task {
            let count = await LocationsNetworkManager.getCountOfLocations()
            if locationsCount != count || locationsCount == 0 {
                for i in 1...count {
                    let location = await LocationsNetworkManager.getLocation(num: i)
                    modelContext.insert(Storege.Location(location: location))
                }
            }
        }

    }
    
    public func requestPersons(personsCount: Int) {
        Task {
            let count = await PersonsNetworkManager.getCountOfPersons()
            if personsCount != count || personsCount == 0 {
                for i in 1...count {
                    let person = await PersonsNetworkManager.getPersonInfo(id: i)
                    await modelContext.insert(Storege.Person(person: person, imageData: PersonsNetworkManager.getDataByURL(apiURL: person.image)))
                }
            }
        }
    }
    
    public func requestEpisodes(episodesCount: Int) {
        Task {
            let count = await EpisodesNetworkManager.getCountOfEpisodes()
            if episodesCount != count || episodesCount == 0 {
                for i in 1...count {
                    let episode = await EpisodesNetworkManager.getEpisodes(id: i)
                    modelContext.insert(Storege.Episode(episode: episode))
                }
            }
        }
    }
    
    public func requestAll(locationCount: Int, personsCount: Int, episodesCount: Int) {
        Task {
            let networkCountOfLocations = await LocationsNetworkManager.getCountOfLocations()
            if locationCount != networkCountOfLocations || locationCount == 0 {
                for i in locationCount + 1...networkCountOfLocations {
                    let location = await LocationsNetworkManager.getLocation(num: i)
                    modelContext.insert(Storege.Location(location: location))
                }
            }
 
            let networkCountOfPersons = await PersonsNetworkManager.getCountOfPersons()
            if personsCount != networkCountOfPersons || personsCount == 0 {
                for i in  personsCount + 1...networkCountOfPersons {
                    let person = await PersonsNetworkManager.getPersonInfo(id: i)
                    await modelContext.insert(Storege.Person(person: person, imageData: PersonsNetworkManager.getDataByURL(apiURL: person.image)))
                }
            }

            let networkCountOfEpisodes = await EpisodesNetworkManager.getCountOfEpisodes()
            if episodesCount != networkCountOfEpisodes || episodesCount == 0 {
                for i in episodesCount + 1...networkCountOfEpisodes {
                    let episode = await EpisodesNetworkManager.getEpisodes(id: i)
                    modelContext.insert(Storege.Episode(episode: episode))
                }
            }
        }
    }
}
