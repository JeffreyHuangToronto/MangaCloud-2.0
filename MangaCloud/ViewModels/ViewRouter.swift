//
//  ViewRouter.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-10.
//

import SwiftUI


enum Page {
    case library
    case latest
    case settings
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .library
}
