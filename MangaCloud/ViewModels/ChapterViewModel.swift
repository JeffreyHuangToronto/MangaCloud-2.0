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
    
    private(set) var loaded: Bool = false
    
    func isLoaded() -> Bool {
        loaded
    }
    
    func getChapterUrls() -> Array<String> {
        return model.chapterImages
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
            model.setChapterIndex(model.chapter_index + 1)
            updateChapterUrls(manga: manga, chapter_index: model.chapter_index)
        }
    }
    
    func goBack(){
        let inBounds = model.chapter_index > 0
        if (inBounds){
            model.setChapterIndex(model.chapter_index - 1)
            updateChapterUrls(manga: manga, chapter_index: model.chapter_index)
        }
    }
    
    func getChapterIndex() -> Int {
        model.chapter_index
    }
    
    func updateChapterUrls(){
        let dynamic_id = manga.cover_url.split(separator: "/")[3].split(separator: ".")[0]
        print(dynamic_id)
        Api().getMangaChapter(manga_id: manga._id, chapter_name: manga.chapter_names[model.chapter_index]) { manga in
            self.model.updateChapterImages(manga.manga_page_urls)
            self.loaded = true
        }
    }
    
    func updateChapterUrls(manga: MangaItem, chapter_index: Int) -> () {
        let dynamic_id = manga.cover_url.split(separator: "/")[3].split(separator: ".")[0]
//        print(dynamic_id)
        Api().getMangaChapter(manga_id: String(dynamic_id), chapter_name: manga.chapter_names[chapter_index]) { manga in
            self.model.updateChapterImages(manga.manga_page_urls)
            self.loaded = true
        }
    }
    
    init(manga: MangaItem, chapter_index: Int){
        model = ChapterModel(chapterIndex: chapter_index)
        self.manga = manga
        updateChapterUrls(manga: manga, chapter_index: chapter_index)
    }
}
