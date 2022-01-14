//
//  MangaInfoViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-01.
//

import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var model: MangaModel
    
    @Published var savedChapterReadHistory: [ChapterReadEntity] = []
    
    private let readMangaDataService = ReadMangaDataService()
    
    func getLatestRead() -> Int? {
//        savedChapterReadHistory = readMangaDataService.savedEntities
//        readMangaDataService.getReadStatus()
        savedChapterReadHistory = readMangaDataService.savedEntities
        print(savedChapterReadHistory)
        if let entity = savedChapterReadHistory.first(where: {$0.mangaId == model.getId()}){
            print("Found")
            model.updateRead(Int(entity.read))
//            savedChapterReadHistory = readMangaDataService.savedEntities
            return Int(entity.read)
        }
        print("Not Found")
        return nil
    }
    
    func updateLatestRead(_ mangaId: String, _ chapterIndex: Int){
        readMangaDataService.addToReadHistory(mangaId, chapterIndex)
        savedChapterReadHistory = readMangaDataService.savedEntities
        model.updateRead(chapterIndex)
    }
    
    func getTitle() -> String{
        model.getTitle()
    }
    
    func getId() -> String{
        model.getId()
    }
    
    func getCoverUrl() -> String {
        model.getCoverUrl()
    }
    
    func getSummary() -> String {
        model.getSummary()
    }
    
    func getChapterNames() -> Array<Double> {
        model.getChapterNames()
    }
    
    func getManga() -> MangaItem {
        model.manga
    }
    
    
    init(manga: MangaItem){
        model = MangaModel(manga: manga)
        savedChapterReadHistory = readMangaDataService.savedEntities
        readMangaDataService.getReadStatus()
        print("MangaViewModel Init")
    }
}
