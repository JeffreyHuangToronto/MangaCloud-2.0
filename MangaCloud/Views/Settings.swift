//
//  Settings.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-17.
//

import SwiftUI
import Auth0

struct Settings: View {
    private let readMangaDataService = ReadMangaDataService.sharedInstance
    private let libraryDataService = LibraryDataService.sharedInstance
    @ObservedObject private var user = UserModel.instance
    var body: some View {
        VStack{
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
            
            Button {
                Auth0
                    .webAuth()
                    .scope("openid profile")
                    .audience("https://mangacloudapi.azurewebsites.net/")
                    .start { result in
                        switch result {
                        case .failure(let error):
                            // Handle the error
                            print("Error: \(error)")
                        case .success(let credentials):
                            // Do something with credentials e.g.: save them.
                            // Auth0 will automatically dismiss the login page
                            user.loggedIn = true
                            
                            if let token = credentials.accessToken {
                                user.accessToken = token
                            }
                            print("Credentials: \(credentials)")
                        }
                }
            } label: {
                Text("Login")
            }
            Button {
                Auth0
                    .webAuth()
                    .clearSession(federated: false) { result in
                        if result {
                            // Session cleared
                            print("LoggedOut")
                            user.loggedIn = false
                        }
                    }
            } label: {
                Text("Logout")
            }.disabled(!user.loggedIn)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
