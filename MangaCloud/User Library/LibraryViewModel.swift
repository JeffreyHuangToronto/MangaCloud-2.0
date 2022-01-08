//
//  LibraryViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import SwiftUI

class LibraryViewModel : ObservableObject {
    @Published private var model: LibraryModel
    
    func getLibraryMangaIds() -> Array<String> {
        model.userMangaIdsList
    }
    
    func getLibrary() -> Array<MangaItem>{
        model.library.mangaList
    }
    
    func isFavorited(_id: String) -> Bool {
        model.hasMangaId(_id)
    }
    
    func favorite(_id: String){
        model.addMangaId(_id: _id)
        Api().getLibraryMangaList(mangaIdList: getLibraryMangaIds(), completion: { userLibrary in
            self.model.updateLibrary(library: userLibrary)
        })
    }
    
    func unfavorite(_id: String){
        model.remMangaId(_id: _id)
        Api().getLibraryMangaList(mangaIdList: getLibraryMangaIds(), completion: { userLibrary in
            self.model.updateLibrary(library: userLibrary)
        })
    }
    
    init(){
        model = LibraryModel()
        Api().getLibraryMangaList(mangaIdList: getLibraryMangaIds(), completion: { userLibrary in
            self.model.updateLibrary(library: userLibrary)
        })
    }
}
