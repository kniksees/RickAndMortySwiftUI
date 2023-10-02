//
//  LocationsScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI



struct LocationsScreenView: View {
    //@State var locations
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                Spacer(minLength: 40)
                HStack {
                    Text("Chatacters")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                Spacer(minLength: 40)
                ScrollView {
                        
                }
            }
        }
    }
}

#Preview {
    LocationsScreenView()
}
