//
//  LocationsScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI



struct LocationsScreenView: View {
    
    struct LocationPreviewReusibleView: View {
        let label: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 40)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    Text(label)
                        .foregroundStyle(.white)
                        .font(.system(size: 20))

            }
            .frame(width: 327, height: 40)
        }
    }
    
    @State var locations = [LocationsNetworkManager.Location]()
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                Spacer(minLength: 40)
                HStack {
                    Text("Locations")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                Spacer(minLength: 40)
                ScrollView(showsIndicators: false) {
                    
                    ForEach(0..<locations.count, id: \.self) { id in
                        NavigationLink {
                            LocationInfoScreenView(url: locations[id].url)
                                .toolbarRole(.editor)
                        } label: {
                            LocationPreviewReusibleView(label: locations[id].name)
                        }
                    }
                }
                .onAppear() {
                    Task {
                        var loc = [LocationsNetworkManager.Location]()
                        let countOfPages = await LocationsNetworkManager.getCountOfPages()
                        for i in 1...countOfPages {
                            let add = await LocationsNetworkManager.getLocations(num: i)
                            loc += add
                        }
                        locations = loc
                    }

                }
            }
        }
    }
}

#Preview {
    LocationsScreenView()
}
