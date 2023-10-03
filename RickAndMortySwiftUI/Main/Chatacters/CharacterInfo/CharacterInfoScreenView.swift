//
//  DetailScreenVIew.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 30.09.2023.
//

import SwiftUI

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
    
    var url: String
    @State var personage: Personage?
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            ScrollView(showsIndicators: false) {
                if personage != nil {
                    Spacer(minLength: 80)
                    HeaderView(image: personage!.header.image, name:  personage!.header.name, status:  personage!.header.status)
                    SectionLabelView(label: "Info")
                    InfoView(species: personage!.info.species, type: personage!.info.type, gender: personage!.info.gender)
                    SectionLabelView(label: "Origin")
                    NavigationLink {
                        if personage!.origin.url.count != 0 {
                            LocationInfoScreenView(url: personage!.origin.url)
                                .toolbarRole(.editor)
                        }
                    } label: {
                        OriginView(name: personage!.origin.name, type: personage!.origin.type)
                    }
                    SectionLabelView(label: "Episodes")
                    ForEach(0..<personage!.episodes.count) {index in
                        NavigationLink {
                            EpisodeInfoScreenView(url: personage!.episodes[index].url)
                                .toolbarRole(.editor)
                        } label: {
                            EpisodeView(name: personage!.episodes[index].name, numberOfEpisode: personage!.episodes[index].numberOfEpisode, date: personage!.episodes[index].date)
                        }
                        
                        
                    }
                }
            }
            .onAppear() {
                Task {
                    let personInfo = await CharactersNetworkManager.getPersonInfo(strUrl: url)
                    let episodesInfo = await CharactersNetworkManager.getEpisodes(strUrl: personInfo.episode)
                    var episodes = [Personage.Episode]()
                    let image = await Image(uiImage: UIImage(data: CharactersNetworkManager.getDataByURL(apiURL: personInfo.image)) ?? UIImage())
                    for i in 0..<episodesInfo.count {
                        episodes.append(Personage.Episode(
                            name: episodesInfo[i].name,
                            numberOfEpisode: Formarters.episodeNumberFormater(episode: episodesInfo[i].episode),
                            date: episodesInfo[i].air_date,
                            url: episodesInfo[i].url))
                    }
                    personage = Personage(
                        header: CharacterInfoScreenView.Personage.Header(
                            image: image,
                            name: personInfo.name,
                            status: personInfo.status ),
                        info: CharacterInfoScreenView.Personage.Info(
                            species: personInfo.species,
                            type: personInfo.type.count == 0 ? "None" : personInfo.type,
                            gender: personInfo.gender),
                        origin: CharacterInfoScreenView.Personage.Origin(
                            name: personInfo.origin.name,
                            type:  personInfo.origin.url.count != 0 ?  await CharactersNetworkManager.getPlanet(strUrl: personInfo.origin.url).type : "None",
                            url: personInfo.origin.url),
                        episodes: episodes)
                }
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
    CharacterInfoScreenView(url: "https://rickandmortyapi.com/api/character/3")
}
