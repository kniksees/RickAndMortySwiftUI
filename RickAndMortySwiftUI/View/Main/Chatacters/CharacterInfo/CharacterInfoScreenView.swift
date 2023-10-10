//
//  DetailScreenVIew.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 30.09.2023.
//

import SwiftUI
import SwiftData

struct CharacterInfoScreenView: View {
    struct HeaderView: View {
        var image: Image
        var name: String
        var status: String
        var body: some View {
            image
                .resizable()
                .frame(width: 148, height: 148)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(name)
                .foregroundStyle(.white)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                .multilineTextAlignment(.center)
            Text(status)
                .foregroundStyle(Color("standartGreenColor"))
        }
    }
    
    struct InfoView: View {
        struct LineInInfoView: View {
            var label: String
            var info: String
            var body: some View {
                HStack {
                    Text(label)
                        .foregroundStyle(Color("standartTextGrayColor"))
                    Spacer()
                    Text(info)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
        }
        var species: String
        var type: String
        var gender: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 124)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack {
                    LineInInfoView(label: "Species:", info: species)
                    LineInInfoView(label: "Type:", info: type)
                    LineInInfoView(label: "Gender:", info: gender)
                }
                .frame(width: 327)
            }
        }
    }
    
    struct SectionLabelView: View {
        var label: String
        var body: some View {
            HStack {
                Text(label)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                Spacer()
            }
            .frame(width: 327)
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    struct OriginView: View {
        var name: String
        var type: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(Color("standartPlanetIconGray"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Image("planetIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0))
                    VStack {
                        HStack {
                            Text(name)
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                        HStack {
                            Text(type)
                                .foregroundStyle(Color("standartGreenColor"))
                                .font(.system(size: 14))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                    }
                    
                }
                .frame(width: 327)
            }
        }
    }
    
    struct EpisodeView: View {
        var name: String
        var numberOfEpisode: String
        var date: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 86)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack {
                    HStack {
                        Text(name)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    HStack {
                        Text(numberOfEpisode)
                            .foregroundStyle(Color("standartGreenColor"))
                            .font(.system(size: 14))
                        Spacer()
                        Text(date)
                            .foregroundStyle(Color("standartTextGrayColor"))
                            .font(.system(size: 14))
                    }
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                }
            }
            .frame(width: 327, height: 86)
            
        }
    }
    
    struct Personage {
        struct Header {
            var image: Image
            var name: String
            var status: String
        }
        struct Info {
            var species: String
            var type: String
            var gender: String
        }
        struct Origin {
            var name: String
            var type: String
            var url: String
        }
        struct Episode {
            var name: String
            var numberOfEpisode: String
            var date: String
            var url: String
        }
        var header: Header
        var info: Info
        var origin: Origin
        var episodes: [Episode]
    }
    
    var id: Int
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        let storageManager = StorageManager(modelContext: modelContext)
        let person = storageManager.getPerson(id: id)
        let origin = storageManager.getLocation(id: person.origin)
        let episodes = storageManager.getEpisodes(setOfId: person.episode)

        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            ScrollView(showsIndicators: false) {
                    Spacer(minLength: 80)
                HeaderView(image: Image(uiImage: UIImage(data: person.image) ?? UIImage()),
                           name:  person.name,
                           status:  person.status)
                    SectionLabelView(label: "Info")
                    InfoView(species: person.species,
                             type: person.type,
                             gender: person.gender)
                    SectionLabelView(label: "Origin")
                    NavigationLink {
                        if person.origin != nil {
                            LocationInfoScreenView(id: origin!.identificator)
                                .toolbarRole(ToolbarRole.editor)
                        }
                    } label: {
                        OriginView(name: origin?.name ?? "Unknown", type: origin?.type ?? "" )
                    }
                    SectionLabelView(label: "Episodes")
                ForEach(episodes) {episode in
                        NavigationLink {
                            EpisodeInfoScreenView(id: episode.identificator)
                                .toolbarRole(.editor)
                        } label: {
                            EpisodeView(name: episode.name, numberOfEpisode: episode.episode, date: episode.air_date)
                        }
                }
                Spacer(minLength: 40)
            }
        }
//        .toolbarBackground(
//            Color("standartDarkBlueColor"),
//            for: .navigationBar)
        .toolbarBackground(.hidden,
                           for: .navigationBar)
        
        
    }
}

#Preview {
    CharacterInfoScreenView(id: 1)
}
