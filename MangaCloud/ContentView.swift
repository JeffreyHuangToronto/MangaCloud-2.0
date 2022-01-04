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
        NavigationView{
            VStack{
                LatestView(viewModel: latest)
            }.navigationTitle("Main")
        }
        
        //        ChapterView(viewModel: chapterView)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
