//
//  LibraryModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import Foundation

struct LibraryModel {
    private(set) var library: Library
    
    mutating func updateLibrary(library: Library){
        self.library = library
    }
    
    
    init(){
        library = Library(mangaList: Array<MangaItem>())
    }
}

struct Library: Codable {
    var mangaList: Array<MangaItem>
}
