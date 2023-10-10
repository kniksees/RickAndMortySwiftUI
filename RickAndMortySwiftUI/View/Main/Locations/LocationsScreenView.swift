//
//  LocationsScreenView.swift
//  RickAndMortySwiftUI
//
//  Created by Дмитрий Ерофеев on 02.10.2023.
//

import SwiftUI
import SwiftData


struct LocationsScreenView: View {
    
    struct LocationPreviewReusibleView: View {
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
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        let storageManager = StorageManager(modelContext: modelContext)
        let locations = storageManager.getLocations()
        
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.size.width,
                       height: UIScreen.main.bounds.size.height)
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
                    ForEach(locations) { location in
                        NavigationLink {
                            LocationInfoScreenView(id: location.identificator)
                                .toolbarRole(ToolbarRole.editor)
                        } label: {
                            LocationPreviewReusibleView(label: location.name)
                        }
                    }
                    Spacer(minLength: 40)
                }
            }
        }
    }
}

#Preview {
    LocationsScreenView()
        .modelContainer(for: [Storege.Location.self], inMemory: true, isAutosaveEnabled: true)
}
