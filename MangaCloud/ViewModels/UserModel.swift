//
//  UserModel.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-22.
//

import Foundation
//import SwiftUi

class UserModel: ObservableObject {
//    @Published var model: MangaModel
    @Published var loggedIn = false
    @Published var accessToken = ""
    
    
    
    static let instance = UserModel()
    
    private init(){
        
    }
    
}
