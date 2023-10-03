//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 30.09.2023.
//

import SwiftUI

struct CharactersScreenView: View {
    
    struct CardReusibleView: View {
        @State var image: Image
        @State var label: String
        var body: some View {
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 156, height: 202)
                    .foregroundStyle(Color("standartGrayColor"))
                VStack {
                    image
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Spacer(minLength: 0)
                    Text(label)
                        .foregroundStyle(Color.white)
                    Spacer(minLength: 0)
      
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                .frame(width: 156, height: 202)
               
                
            }
        }
    }
    
    @State private var personages = [CharactersNetworkManager.Person]()
    @State private var personagesImages = [Image]()
    
    var body: some View {
        
        //NavigationStack {
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
                let columns = [
                    GridItem(spacing: 20, alignment: Alignment(horizontal: .trailing, vertical: .top)),
                    GridItem(spacing: 20, alignment: Alignment(horizontal: .leading, vertical: .top))
                ]
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(0..<min(personagesImages.count, personages.count), id: \.self) { number in
                            
                            NavigationLink {
                                CharacterInfoScreenView(url:  personages[number].url)
                                    .toolbarRole(.editor)
                                
                            } label: {
                                CardReusibleView(image: personagesImages[number], label: personages[number].name)
                            }
                            
                        }
                    }
                }.onAppear() {
                    Task {
                        let countOfPages = await CharactersNetworkManager.getCountOfPages()
                        for i in 1...countOfPages {
                            let add = await CharactersNetworkManager.makeResponse(num: i)
                            personages += add
                            for i in 0..<add.count {
                                let data = await CharactersNetworkManager.getDataByURL(apiURL: add[i].image)
                                personagesImages.append(Image(uiImage: UIImage(data: data) ?? UIImage()))
                            }
                        }
                    }
                }
            }
        }
        //        }
        //        .accentColor(.white)
    }
}

#Preview {
    CharactersScreenView()
}
