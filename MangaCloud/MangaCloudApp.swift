//
//  MangaCloudApp.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-11-20.
//

import SwiftUI

@main
struct MangaCloudApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    @StateObject var latestViewModel = LatestViewModel()
    @StateObject var libraryViewModel = LibraryViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(viewRouter)
                .environmentObject(latestViewModel)
                .environmentObject(libraryViewModel)
        }
    }
}
