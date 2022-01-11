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
    
    var body: some Scene {
        WindowGroup {
            MainContentView(viewRouter: viewRouter)
        }
    }
}
