//
//  ContentView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-11-20.
//

import SwiftUI

struct ContentView: View {
    let latest = LatestViewModel()
    
    @StateObject var userLibraryViewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView{
            TabView {
                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "bookmark.circle.fill")
                    }
                
                LatestView(viewModel: latest)
                    .tabItem {
                        Label("Latest", systemImage: "books.vertical.fill")
                    }
                
                Text("Settings")
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        }
        .environmentObject(userLibraryViewModel)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

//struct userData: ObservableObject {
//    var mangaIdList: Array<String>
//    init(){
//        mangaIdList = []
//    }
//}
