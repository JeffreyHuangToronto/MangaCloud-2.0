//
//  LibraryViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import SwiftUI
import Combine

class LibraryViewModel : ObservableObject {
    @Published private var model: LibraryModel
    
    @ObservedObject private var user = UserModel.instance
    
    private var savedMangaIds: [String] = []
    
    private let libraryDataService = LibraryDataService.sharedInstance
    
    func updateSavedLibrary(_ mangaId: String) {
        libraryDataService.addToLibrary(mangaId)
        savedMangaIds = libraryDataService.savedEntities.map { $0.mangaId! }
        updateLibrary()
    }
    
    
    func getLibraryMangaIds() -> Array<String> {
        return savedMangaIds
    }
    
    func getLibrary() -> Array<MangaItem>{
        model.library.mangaList
    }
    
    func isFavorited(_id: String) -> Bool {
        return savedMangaIds.firstIndex(of: _id) != nil
    }
    
    func updateLibrary(){
        savedMangaIds = libraryDataService.savedEntities.map { $0.mangaId!}
//        if (user.loggedIn){
            Api().getLibraryMangaList(mangaIdList: getLibraryMangaIds(), completion: { userLibrary in
                self.model.updateLibrary(library: userLibrary)
            })
//        }
    }
    
    func updateLibrary(savedManga: [String]){
        savedMangaIds = libraryDataService.savedEntities.map { $0.mangaId!}
//        if (user.loggedIn){
            Api().getLibraryMangaList(mangaIdList: getLibraryMangaIds(), completion: { userLibrary in
                self.model.updateLibrary(library: userLibrary)
            })
//        }
    }
    
    init(){
        model = LibraryModel()
        updateLibrary()
    }
    
    init(savedManga: [String]){
        model = LibraryModel()
        updateLibrary(savedManga: savedManga)
    }
}
