//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 30.09.2023.
//

import SwiftUI
import SwiftData

struct CharactersScreenView: View {
    
    struct CardReusibleView: View {
        var image: Image
        var label: String
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
                    Spacer(minLength: 0)
                    Text(label)
                        .foregroundStyle(Color.white)
                    Spacer(minLength: 0)
      
                }
                .padding(EdgeInsets(top: 8, 
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0))
                .frame(width: 156, height: 202)   
            }
        }
    }
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let storageManager = StorageManager(modelContext: modelContext)
        let persons = storageManager.getPersons()
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
                        ForEach(persons) { person in
                            NavigationLink {
                                CharacterInfoScreenView(id: person.identificator)
                                    .toolbarRole(.editor)
                            } label: {
                                CardReusibleView(image: Image(uiImage: UIImage(data: person.image) ?? UIImage()), label: person.name)
                            }
                        }
                    }
                    Spacer(minLength: 40)
                }
            }
        }
    }
}

#Preview {
    CharactersScreenView()
}
