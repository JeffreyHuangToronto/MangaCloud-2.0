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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))]){
                    ForEach(latest, id: \.self) { manga in
                        let mangaViewModel = MangaViewModel(manga: manga)
                        NavigationLink(destination: MangaView(viewModel: mangaViewModel)){
                            MangaItemView(manga: manga)
                        }.isDetailLink(false)
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
//                        .shadow(color: Color(.label), radius: 5, x: 5, y: 5)
//                        .border(.red)
                    
                    Text(manga.title + "\n")
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                        .border(.red)
//                        .lineLimit(2)
                        
                    
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                    ProgressView()
                } else {
                    Color.blue // Acts as a placeholder.
                }
                
            }
            .padding(ThemeSettings.normalPadding)
//                .border(Color.red)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let latestViewModel = LatestViewModel()
        LatestView(viewModel: latestViewModel)
    }
}

private struct ThemeSettings {
    static let primaryColor: Color = Color(UIColor.systemGray6)
    static let secoundaryColor: Color = Color(UIColor.systemBackground)
    static let textColor: Color = Color(UIColor.label)
    static let buttonColor: Color = Color(UIColor.label)
    static let accentColor: Color = Color(UIColor.systemIndigo)
    static let iconSize: CGFloat = 20
    static let largeIconSize: CGFloat = 30
    static let menuOpacity: Double = 0.8
    static let topBarHeight: Double = 100
    static let topBarWidth: Double = .infinity
    static let normalPadding: Double = 20
    static let largeTitleColor: Color = .white
    static let heroHeight: Double = Double(UIScreen.main.bounds.height / 4)
}
