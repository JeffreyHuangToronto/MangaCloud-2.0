//
//  PreviewProvider.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-09.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}


class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    let savedIds = ["fc918572"]
    
    @StateObject var userLibraryViewModel = LibraryViewModel()
    
    private init () {}
    
    
    
    
    
    let manga = MangaItem(_id: "fc918572", title: "My Girlfriend Is A Dragon",summary: "This adventure started with a young alchemist, who tried to rescue a princess, but this princess turned out to be a dragon. What will result in this strange, but funny meeting?", cover_url: "https://ww.mangakakalot.tv/mangaimage/fc918572.jpg", chapter_names: [1,2])
    
    
}
