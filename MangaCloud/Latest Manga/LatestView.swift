//
//  MainView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-27.
//

import SwiftUI

struct LatestView: View {
    @ObservedObject var viewModel: LatestViewModel
    
    var body: some View {
        let latest = viewModel.getLatestManga().latest
        
        if  latest.count != 0 {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]){
                    ForEach(latest, id: \.self) { manga in
                        let mangaViewModel = MangaViewModel(manga: manga)
                        NavigationLink(destination: MangaView(viewModel: mangaViewModel)){
                            MangaItemView(manga: manga)
                        }
//                        .border(Color.red)
                        .padding(2)
                    }
                }
            }
        }
    }
}


struct MangaItemView: View {
    var manga: MangaItem
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0){
            AsyncImage(url: URL(string: manga.cover_url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(3/4, contentMode: .fill) // Displays the loaded image.
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
            Text(manga.title + "\n")
                .foregroundColor(.black)
                .lineLimit(2)
        }
//        .fixedSize(horizontal: true, vertical: true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let latestViewModel = LatestViewModel()
        LatestView(viewModel: latestViewModel)
    }
}
