//
//  LocationInfoScreen.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 03.10.2023.
//

import SwiftUI

struct EpisodeInfoScreenView: View {
    
    struct SectionLabelView: View {
        @State var label: String
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
    
    struct HeaderView: View {
        var name: String
        var body: some View {
            Text(name)
                .foregroundStyle(.white)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
        }
    }
    
    struct InfoView: View {
        struct LineInInfoView: View {
            @State var label: String
            @State var info: String
            var body: some View {
                HStack {
                    Text(label)
                        .foregroundStyle(Color("standartTextGrayColor"))
                    Spacer()
                    Text(info)
                        .foregroundStyle(.white)
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
        }
        @State var airDate: String
        @State var episode: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 80)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack {
                    LineInInfoView(label: "Air date:", info: airDate)
                    LineInInfoView(label: "Episode:", info: episode)
                }
                .frame(width: 327)
            }
        }
    }
    
    struct CardReusibleView: View {
        @State var image: Image
        @State var label: String
        var body: some View {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 78)
                    .foregroundStyle(Color("standartGrayColor"))
                VStack {
                    image
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    Text(label)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                    Spacer()
                }
                .padding(4)
                .frame(width: 78)
                
            }
        }
    }
    
    var url: String
    @State var episode: EpisodesNetworkManager.EpisodeIfo?
    @State var persons = [CharactersNetworkManager.PersonInfo]()
    @State var personsImages = [Image]()
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                if episode != nil {
                    Spacer(minLength: 40)
                    HStack {
                        HeaderView(name: episode!.name)
                    }
                    .frame(width: 327)
                    let columns = [
                        GridItem(spacing: 5, alignment: Alignment(horizontal: .trailing, vertical: .top)),
                        GridItem(spacing: 5, alignment: Alignment(horizontal: .trailing, vertical: .top)),
                        GridItem(spacing: 5, alignment: Alignment(horizontal: .trailing, vertical: .top)),
                        GridItem(spacing: 5, alignment: Alignment(horizontal: .leading, vertical: .top))
                    ]
                    ScrollView(showsIndicators: false) {
                        SectionLabelView(label: "Info")
                        InfoView(airDate: episode!.air_date, episode: Formarters.episodeNumberFormater(episode: episode!.episode))
                        SectionLabelView(label: "Characters")
                        
                        LazyVGrid(columns: columns, spacing: 5) {
                            
                            ForEach(0..<min(persons.count, personsImages.count), id: \.self) { number in
                                NavigationLink {
                                    CharacterInfoScreenView(url:  persons[number].url)
                                        .toolbarRole(.editor)
                                } label: {
                                    CardReusibleView(image: personsImages[number],  label: persons[number].name)
                                }

       
                            }
                        }
                    }
                    .frame(width: 327)
                    .onAppear() {
                        Task {
                            var tempPersons = [CharactersNetworkManager.PersonInfo]()
                            for i in 0..<episode!.characters.count {
                                await tempPersons.append(CharactersNetworkManager.getPersonInfo(strUrl:episode!.characters[i]))
                            }
                            persons = tempPersons
                            var tempImages = [Image]()
                            for i in 0..<tempPersons.count {
                                tempImages.append(await Image(uiImage: UIImage(data: CharactersNetworkManager.getDataByURL(apiURL: tempPersons[i].image)) ?? UIImage()))
                            }
                            personsImages = tempImages
                        }
                    }
                }
            }
        }.onAppear() {
            Task {
                episode = await EpisodesNetworkManager.getLocation(url: url)
            }
        }
    }
}

#Preview {
    EpisodeInfoScreenView(url: "https://rickandmortyapi.com/api/episode/9")
}

