//
//  Settings.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-17.
//

import SwiftUI

struct Settings: View {
    private let readMangaDataService = ReadMangaDataService.sharedInstance
    private let libraryDataService = LibraryDataService.sharedInstance
    var body: some View {
        Button {
            readMangaDataService.clearAllReadStatus()
        } label: {
            Text("Clear Read History")
        }
        Button {
            libraryDataService.clearAllLibrary()
        } label: {
            Text("Clear Library")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
