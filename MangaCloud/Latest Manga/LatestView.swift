//
//  MainView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-27.
//

import SwiftUI

struct LatestView: View {
    @ObservedObject var viewModel: LatestViewModel
    
    var body: some View {
        let latest = viewModel.getLatestManga().latest
        
        if  latest.count != 0 {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]){
                    ForEach(latest, id: \.self) { manga in
                        let mangaViewModel = MangaViewModel(manga: manga)
                        NavigationLink(destination: MangaView(viewModel: mangaViewModel)){
                            MangaItemView(manga: manga)
                        }
                        //                            .padding(2)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        else{
            Text("Loading Manga")
        }
    }
}


struct MangaItemView: View {
    var manga: MangaItem
    
    @State var isHover = false
    
    
    var body: some View {
        
        AsyncImage(url: URL(string: manga.cover_url)) { phase in
            VStack(alignment: .leading){
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(3/4, contentMode: .fill) // Displays the loaded image.
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .shadow(color: Color(.label), radius: 5, x: 5, y: 5)
                        .border(.red)
                    Text(manga.title + "\n")
                        .foregroundColor(Color(.label))
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                        .padding(3)
                        .border(.red)
                        .lineLimit(2)
                        
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                    ProgressView()
                } else {
                    Color.blue // Acts as a placeholder.
                }
                
            }.padding()
                .border(Color.red)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let latestViewModel = LatestViewModel()
        LatestView(viewModel: latestViewModel)
    }
}
