//
//  ContentView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-11-20.
//

import SwiftUI

struct ContentView: View {
    let latest = LatestViewModel()
    
    var body: some View {
        //        NavigationView{
        VStack{
            
            TabView {
                Text("View 1")
                    .tabItem {
                        Label("Library", systemImage: "bookmarks")
                    }
                
                LatestView(viewModel: latest)
                    .tabItem {
                        Label("Latest", systemImage: "")
                    }
                
                Text("View 3")
                    .tabItem {
                        Label("Community", systemImage: "theatermasks")
                    }
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        //        }
        
        //        ChapterView(viewModel: chapterView)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
