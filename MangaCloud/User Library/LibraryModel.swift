//
//  LibraryModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import Foundation

struct LibraryModel {
    private(set) var library: Library
    private(set) var userMangaIdsList: Array<String>
    
    mutating func updateLibrary(library: Library){
        self.library = library
    }
    
    mutating func addMangaId(_id: String){
//        userMangaIdsList.push()
        if (!hasMangaId(_id)){
            // It's not in the list
            print("Not in")
            userMangaIdsList.append(_id)
            print(userMangaIdsList)
        }
        else{
            print("In")
        }
    }
    
    mutating func remMangaId(_id: String){
        if (hasMangaId(_id)){
            userMangaIdsList.remove(at: userMangaIdsList.firstIndex(of: _id)!) // TODO: Potential Problem
        }
    }
    
    func hasMangaId(_ _id: String) -> Bool {
        return userMangaIdsList.firstIndex(of: _id) != nil
    }
    
    init(){
        library = Library(mangaList: Array<MangaItem>())
        userMangaIdsList = [] // TODO: Get it from saved storage, maybe Core Data
    }
}

struct Library: Codable {
    var mangaList: Array<MangaItem>
}
