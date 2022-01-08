//
//  LibraryView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var viewModel: LibraryViewModel
    
    var body: some View {
        let library = viewModel.getLibrary()
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))]){
                ForEach(library, id: \.self) { manga in
                    let mangaViewModel = MangaViewModel(manga: manga)
                    NavigationLink(destination: MangaView(viewModel: mangaViewModel)){
                        MangaItemView(manga: manga)
                    }
                }
            }
        }.refreshable {
            print("Refresh")
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct LibraryView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        LibraryView()
    }
}
