//
//  LocationsScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 03.10.2023.
//

import SwiftUI
import SwiftData

struct EpisodesScreenView: View {
    
    struct EpisodePreviewReusibleView: View {
        let label: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Text(label)
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 5,
                                            leading: 0,
                                            bottom: 5,
                                            trailing: 0))
            }
            .frame(width: 327)
        }
    }
    
    @Query private var episodes: [Storege.Episode]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                Spacer(minLength: 40)
                HStack {
                    Text("Episodes")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                Spacer(minLength: 40)
                ScrollView(showsIndicators: false) {
                    ForEach(episodes.sorted(by: {$0.identificator < $1.identificator})) { episode in
                        NavigationLink {
                            EpisodeInfoScreenView(id: episode.identificator)
                                .toolbarRole(.editor)
                        } label: {
                            EpisodePreviewReusibleView(label: episode.name)
                        }
                    }
                    Spacer(minLength: 40)
                }
            }
        }
    }
}

#Preview {
    EpisodesScreenView()
}

