//
//  LocationsScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 03.10.2023.
//

import SwiftUI



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
    
    @State var episodes = [EpisodesNetworkManager.Episode]()
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
                    
                    ForEach(0..<episodes.count, id: \.self) { id in
                        NavigationLink {
                            EpisodeInfoScreenView(url: episodes[id].url)
                                .toolbarRole(.editor)
                        } label: {
                            EpisodePreviewReusibleView(label: episodes[id].name)
                        }
                    }
                    Spacer(minLength: 40)
                }
                .onAppear() {
                    Task {
                        var ep = [EpisodesNetworkManager.Episode]()
                        let countOfPages = await EpisodesNetworkManager.getCountOfPages()
                        for i in 1...countOfPages {
                            let add = await EpisodesNetworkManager.getEpisodes(num: i)
                            ep += add
                        }
                        episodes = ep
                    }
                }
            }
        }
    }
}

#Preview {
    EpisodesScreenView()
}

