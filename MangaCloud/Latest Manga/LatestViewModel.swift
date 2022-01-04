//
//  LatestViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-29.
//

import SwiftUI

class LatestViewModel : ObservableObject {
    @Published private var model: LatestModel
    
    func updateLatest(_ latest: LatestMangaList) {
        model.updateLatestManga(latestManga: latest)
    }
    
    func getLatestManga() -> LatestMangaList{
        model.latestManga
    }
    
    init(){
        model = LatestModel()
        Api().getLatestChapters { latest in
            self.model.updateLatestManga(latestManga: latest)
        }
        
    }
}
