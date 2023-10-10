//
//  LocationInfoScreen.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI
import SwiftData

struct LocationInfoScreenView: View {
    
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
                        .lineLimit(1)
                }
                .padding(EdgeInsets(top: 5,
                                    leading: 15,
                                    bottom: 5,
                                    trailing: 15))
            }
        }
        var type: String
        var dimension: String
        var body: some View {
            ZStack {
                Rectangle()
                    .frame(width: 327, height: 80)
                    .foregroundStyle(Color("standartGrayColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack {
                    LineInInfoView(label: "Type:", info: type)
                    LineInInfoView(label: "Dimension:", info: dimension)
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
    
    var id: Int
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {

        let storageManager = StorageManager(modelContext: modelContext)
        let location = storageManager.getLocation(id: id)!
        let persons = storageManager.getPersons(setOfId: location.residents)
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                .ignoresSafeArea()
                .foregroundStyle(Color("standartDarkBlueColor"))
            VStack {
                Spacer(minLength: 40)
                HStack {
                    HeaderView(name: location.name)
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
                    InfoView(type: location.type, dimension: location.dimension)
                    SectionLabelView(label: "Residents")
                    
                    LazyVGrid(columns: columns, spacing: 5) {
                        
                        ForEach(persons) { person in
                            NavigationLink {
                                CharacterInfoScreenView(id:  person.identificator)
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
    LocationInfoScreenView(id: 1)
}
