//
//  MainScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI

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

struct MainScreenView: View {
    
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
        }
        .accentColor(.white)
    }
}

#Preview {
    MainScreenView()
}
