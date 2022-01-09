//
//  MangaInfoModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-01.
//

import Foundation

struct MangaModel {
    private(set) var manga: MangaItem
    
    func getTitle() -> String {
        manga.title
    }
    
    func getCoverUrl() -> String {
        manga.cover_url
    }
    
    func getId() -> String {
        manga._id
    }
    
    func getChapterNames() -> Array<Double> {
        manga.chapter_names
    }
    
    func getSummary() -> String {
        manga.summary
    }
    
    
    
    init(manga: MangaItem){
        self.manga = manga
    }
}

struct MangaItem: Codable, Hashable {
    var _id: String
    var title: String
    var summary: String
    var cover_url: String
    var chapter_names: Array<Double>
}
