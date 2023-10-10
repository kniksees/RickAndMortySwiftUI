//
//  LocationInfoScreen.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 03.10.2023.
//

import SwiftUI
import SwiftData

struct EpisodeInfoScreenView: View {
    
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
            var label: String
            var info: String
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
        var airDate: String
        var episode: String
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
        var image: Image
        var label: String
        var body: some View {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 78, height: 101)
                    .foregroundStyle(Color("standartGrayColor"))
                VStack {
                    image
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    Spacer(minLength: 0)
                    Text(label)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                    Spacer(minLength: 0)
                }
                .padding(EdgeInsets(top: 4,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0))
                .frame(width: 78, height: 101)
            }
        }
    }
    
    @Query private var locations: [Storege.Location]
    @Query private var persons: [Storege.Person]
    @Query private var episodes: [Storege.Episode]
    var id: Int
    
    var body: some View {
        let episode = episodes.filter({$0.identificator == id}).first!
        let personsFiltered = persons.filter({Set(episode.characters).contains($0.identificator)}).sorted(by: {$0.identificator < $1.identificator})
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                    Spacer(minLength: 40)
                    HStack {
                        HeaderView(name: episode.name)
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
                        InfoView(airDate: episode.air_date, episode: Formarters.episodeNumberFormater(episode: episode.episode))
                        SectionLabelView(label: "Characters")
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(personsFiltered) { person in
                                NavigationLink {
                                    CharacterInfoScreenView(id: person.identificator)
                                        .toolbarRole(.editor)
                                } label: {
                                    CardReusibleView(image: Image(uiImage: UIImage(data: person.image) ?? UIImage()),  label: person.name)
                                }
                            }
                        }
                        Spacer(minLength: 40)
                    }
                    .frame(width: 327)
            }
        }
    }
}

#Preview {
    EpisodeInfoScreenView(id: 1)
}

