//
//  MangaEngine.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-24.
//

import Foundation
import SwiftUI

struct ChapterModel{
//    private(set) var manga: MangaItem
    private(set) var chapterImages: Array<String>
    private(set) var chapter_index: Int
    
    mutating func updateChapterImages(_ pages: Array<String>){
        chapterImages = pages
    }
    
    func getChapterImages() -> [String]{
        chapterImages
    }
    
    mutating func setChapterIndex(_ index: Int) {
        chapter_index = index
    }
    
    init(chapterIndex: Int){
        chapterImages = []
        chapter_index = chapterIndex
    }
}


struct MangaChapter: Codable{
    var manga_page_urls: Array<String>
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
