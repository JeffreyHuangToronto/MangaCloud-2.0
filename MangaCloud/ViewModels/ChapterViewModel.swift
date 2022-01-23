//
//  ChapterViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-24.
//

import SwiftUI

class ChapterViewModel : ObservableObject {
    @Published private var model: ChapterModel
    private(set) var manga: MangaItem
    
    private let readMangaDataService = ReadMangaDataService.sharedInstance
    
//    @Published private(set) var loaded: Bool = false
    @Published var progress: Float = 1
    
//    func isLoaded() -> Bool {
//        loaded
//    }
    
    func getChapterUrls() -> Array<String> {
        model.chapterImages
    }
    
    func getChapterImages() -> [String] {
        model.getChapterImages()
    }
    
    func setChapterIndex(_ index: Int) {
        model.setChapterIndex(index)
        updateChapterUrls()
    }
    
    func getChapterName() -> Double{
        manga.chapter_names[getChapterIndex()]
    }
    
    func getTitle() -> String{
        manga.title
    }
    
    func goNext(){
        let inBounds = model.chapter_index < manga.chapter_names.count - 1
        if (inBounds){
            progress = 1
            readMangaDataService.setMangaChapterReadStatus(manga._id, model.chapter_index + 1)
            model.setChapterIndex(model.chapter_index + 1)
            updateChapterUrls(manga: manga, chapter_index: model.chapter_index)
        }
    }
    
    func goBack(){
        let inBounds = model.chapter_index > 0
        if (inBounds){
            progress = 1
            model.setChapterIndex(model.chapter_index - 1)
            updateChapterUrls(manga: manga, chapter_index: model.chapter_index)
        }
    }
    
    func getChapterIndex() -> Int {
        model.chapter_index
    }
    
    func updateChapterUrls(){
        let dynamic_id = manga.cover_url.split(separator: "/")[3].split(separator: ".")[0]
        if (model.chapter_index != -1){
            self.progress = 2
            Api().getMangaChapter(manga_id: String(dynamic_id), chapter_name: manga.chapter_names[model.chapter_index]) { mangaObj in
//                print("\(dynamic_id) \(self.manga.chapter_names[self.model.chapter_index]) \(mangaObj)")
                self.model.updateChapterImages(mangaObj.manga_page_urls)
                
                self.progress = 4
            }
        }
    }
    
    func updateChapterUrls(manga: MangaItem, chapter_index: Int) -> () {
        if (chapter_index != -1){
            let dynamic_id = manga.cover_url.split(separator: "/")[3].split(separator: ".")[0]
            self.progress = 2
            Api().getMangaChapter(manga_id: String(dynamic_id), chapter_name: manga.chapter_names[chapter_index]) { mangaObj in
//                print("\(dynamic_id) \(self.manga.chapter_names[self.model.chapter_index]) \(mangaObj)")
                self.model.updateChapterImages(mangaObj.manga_page_urls)
                self.progress = 4
            }
        }
    }
    
    init(manga: MangaItem, chapter_index: Int){
        print("Chapter View Model Created")
        progress = 1
        model = ChapterModel(chapterIndex: chapter_index)
        self.manga = manga
        updateChapterUrls(manga: manga, chapter_index: chapter_index)
        
    }
}
