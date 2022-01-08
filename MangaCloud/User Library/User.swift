//
//  User.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-07.
//

import SwiftUI

class User : ObservableObject {
    @Published private var mangaIdList: Array<String>
    
    func getMangaIdList() -> Array<String>{
        mangaIdList
    }
    
    // TODO: Make it so that it will check storage for the list and if not found, create it
    init(){
        mangaIdList = []
    }
}
