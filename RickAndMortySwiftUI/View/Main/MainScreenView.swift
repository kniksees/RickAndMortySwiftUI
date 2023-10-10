//
//  MainScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI
import SwiftData

struct MainScreenView: View {
    
    struct BaseLinkReusibleView: View {
        let label: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 80)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Text(label)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
            }
        }
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) var scenePhase
    @Query private var locations: [Storege.Location]
    @Query private var persons: [Storege.Person]
    @Query private var episodes: [Storege.Episode]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .ignoresSafeArea()
                    .foregroundStyle(Color("standartDarkBlueColor"))
                ScrollView(showsIndicators: false) {
                    Spacer(minLength: 250)
                    NavigationLink {
                        CharactersScreenView()
                            .toolbarRole(.editor)
                    } label: {
                        BaseLinkReusibleView(label: "Characters")
                    }
                    NavigationLink {
                        LocationsScreenView()
                            .toolbarRole(.editor)
                    } label: {
                        BaseLinkReusibleView(label: "Locations")
                    }
                    NavigationLink {
                        EpisodesScreenView()
                            .toolbarRole(.editor)
                    } label: {
                        BaseLinkReusibleView(label: "Episodes")
                    }
                }
               
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    Task {
                        let count = await LocationsNetworkManager.getCountOfLocations()
                        if locations.count != count || locations.count == 0 {
                            for i in locations.count + 1...count {
                                let location = await LocationsNetworkManager.getLocation(num: i)
                                modelContext.insert(Storege.Location(location: location))
                            }
                        }
                    }
                    Task {
                        let count = await PersonsNetworkManager.getCountOfPersons()
                        if persons.count != count || persons.count == 0 {
                            for i in  persons.count + 1...count {
                                let person = await PersonsNetworkManager.getPersonInfo(id: i)
                                await modelContext.insert(Storege.Person(person: person, imageData: PersonsNetworkManager.getDataByURL(apiURL: person.image)))
                            }
                        }
                    }
                    Task {
                        let count = await EpisodesNetworkManager.getCountOfEpisodes()
                        if episodes.count != count || episodes.count == 0 {
                            for i in episodes.count + 1...count {
                                let episode = await EpisodesNetworkManager.getEpisodes(id: i)
                                modelContext.insert(Storege.Episode(episode: episode))
                            }
                        }
                    }
                }
            }
        }
        .accentColor(.white)
    }
}

#Preview {
    MainScreenView()
        .modelContainer(for: [Storege.Location.self], inMemory: true, isAutosaveEnabled: true)
}
