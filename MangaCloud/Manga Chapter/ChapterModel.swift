//
//  MangaEngine.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-24.
//

import Foundation
import SwiftUI

struct ChapterModel{
    private(set) var chapterImages: Array<String>
    private(set) var manga: MangaItem
    private(set) var chapter_index: Int
    private(set) var isLoaded = false
    
    mutating func updateChapterImages(_ pages: Array<String>){
        chapterImages = pages
        isLoaded = true
    }
    
    func isChapterLoaded() -> Bool {
        isLoaded
    }
    
    mutating func goNext(){
        isLoaded = false
        chapter_index += 1
    }
    
    mutating func goBack(){
        isLoaded = false
        chapter_index -= 1
    }
    
    mutating func loaded(){
        isLoaded = true
    }
    
    init(mangaItem: MangaItem, chapterIndex: Int){
        chapterImages = []
        manga = mangaItem
        chapter_index = chapterIndex
        isLoaded = false
    }
}


struct MangaChapter: Codable{
    var manga_page_urls: Array<String>
}

struct LatestMangaList: Codable{
    var latest: Array<MangaItem>
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
