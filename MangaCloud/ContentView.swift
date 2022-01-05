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
        //        VStack{
        //
        NavigationView{
            TabView {
                Text("Library")
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
            //        }
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
