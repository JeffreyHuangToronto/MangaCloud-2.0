//
//  MangaInfoViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-01.
//

import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var model: MangaModel
    
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
    }
}
