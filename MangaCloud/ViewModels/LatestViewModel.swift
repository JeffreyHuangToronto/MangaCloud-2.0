//
//  LatestViewModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-29.
//

import SwiftUI

class LatestViewModel : ObservableObject {
    @Published private var model: LatestModel
    
    @ObservedObject private var user = UserModel.instance
    func updateLatest(_ latest: LatestMangaList) {
        model.updateLatestManga(latestManga: latest)
    }
    
    func getLatestManga() -> LatestMangaList{
        model.latestManga
    }
    
    func update(){
        Api().getLatestChapters(user.accessToken) { latest in
            self.model.updateLatestManga(latestManga: latest)
        }
    }
    
    init(){
        model = LatestModel()
        print("Init: Getting Latest Manga")
        if (user.loggedIn){
            Api().getLatestChapters(user.accessToken){ latest in
                self.model.updateLatestManga(latestManga: latest)
            }
        }
    }
}
