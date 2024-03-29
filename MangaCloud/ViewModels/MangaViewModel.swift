//
//  MangaInfoViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-01.
//

import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var model: MangaModel
    
    
    // TODO: Rename this long var name
//    private var mangaChapterReadStatusHistory: [ChapterReadEntity] = []
    
//    private let readMangaDataService = ReadMangaDataService.sharedInstance
    
//    func getMangaChapterReadStatus(_ mangaId: String) -> Int?{
//        if let entity = mangaChapterReadStatusHistory.first(where: { $0.mangaId == mangaId }) {
//            return Int(entity.read)
//        } else {
//            return nil
//        }
//    }
//    func setMangaChapterReadStatus(_ mangaId: String, _ chapterIndex: Int){
//        readMangaDataService.setMangaChapterReadStatus(mangaId, chapterIndex)
//    }
    
    
    // TODO: Rename this long function
//    func getMangaChapterReadStatusHistory(){
//        mangaChapterReadStatusHistory =  readMangaDataService.savedEntities
//    }
    
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
//        getMangaChapterReadStatusHistory()
    }
}
