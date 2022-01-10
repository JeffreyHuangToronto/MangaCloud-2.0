//
//  LatestModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-02.
//

import Foundation

struct LatestModel {
    private(set) var latestManga: LatestMangaList

    mutating func updateLatestManga(latestManga: LatestMangaList){
        self.latestManga = latestManga
    }
    
    init(){
        latestManga = LatestMangaList(latest: Array<MangaItem>())
    }
    
}

struct LatestMangaList: Codable{
    var latest: Array<MangaItem>
}
