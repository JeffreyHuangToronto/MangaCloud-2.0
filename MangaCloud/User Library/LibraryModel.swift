//
//  LibraryModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import Foundation

struct LibraryModel {
    private(set) var library: Library
//    private(set) var userMangaIdsList: Array<String>
    
    mutating func updateLibrary(library: Library){
        self.library = library
    }
    
//    mutating func addMangaId(_id: String){
//        if (!hasMangaId(_id)){
//            userMangaIdsList.append(_id)
//        }
//    }
    
//    mutating func removeMangaId(_id: String){
//        if (hasMangaId(_id)){
//            userMangaIdsList.remove(at: userMangaIdsList.firstIndex(of: _id)!) // TODO: Potential Problem
//        }
//    }
    
//    func hasMangaId(_ _id: String) -> Bool {
//        return userMangaIdsList.firstIndex(of: _id) != nil
//    }
    
    init(){
        library = Library(mangaList: Array<MangaItem>())
//        userMangaIdsList = [] // TODO: Get it from saved storage, maybe Core Data
    }
}

struct Library: Codable {
    var mangaList: Array<MangaItem>
}
