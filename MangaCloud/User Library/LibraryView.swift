//
//  LibraryView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        List(){
            MangaItemView(manga: MangaItem(_id: "manga-fc918572", title: "My Girlfriend Is A Dragon",summary: "This adventure started with a young alchemist, who tried to rescue a princess, but this princess turned out to be a dragon. What will result in this strange, but funny meeting?", cover_url: "https://ww.mangakakalot.tv/mangaimage/fc918572.jpg", chapter_names: [1,2]))
        }.refreshable {
            
        }
        
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
