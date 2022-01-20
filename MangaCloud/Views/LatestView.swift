//
//  MainView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-27.
//

import SwiftUI

struct LatestView: View {
    @ObservedObject var viewModel: LatestViewModel
    
    @State private var selectedManga: MangaItem? = nil
    @State private var showDetailView: Bool = false
    @State private var searchText = ""
    
    @State private var search: [MangaItem] = []
    
    init(viewModel: LatestViewModel){
        self.viewModel = viewModel
        print("Init: Creating LatestView")
    }
    
    var searchResults: [MangaItem] {
        if searchText.isEmpty {
            return viewModel.getLatestManga().latest
        } else {
            return search
        }
    }
    
    func getSearchResult() {
        print("Searching")
        Api().search(searchText, completion: { SearchItem in
            search = SearchItem.result
        })
    }
    
    
    
    var body: some View {
        let latest = viewModel.getLatestManga().latest
        
        if  latest.count != 0 {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))]){
                    ForEach(searchResults, id: \.self) { manga in
                        MangaItemView(manga: manga)
                            .onTapGesture {
                                segue(manga: manga)
                            }
                    }
                }
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                getSearchResult()
            }
            
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Manga")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(false)
            .background(content: {
                NavigationLink(isActive: $showDetailView) {
                    MangaDetailView(manga: $selectedManga)
                } label: {
                    EmptyView()
                }
                
            })
        }
        else{
            Text("Loading Manga")
        }
    }
    
    private func segue(manga: MangaItem){
        selectedManga = manga
        showDetailView.toggle()
    }
}


struct MangaItemView: View {
    var manga: MangaItem
    
    @State var isHover = false
    
    
    var body: some View {
        
        AsyncImage(url: URL(string: manga.cover_url)) { phase in
            VStack(alignment: .center){
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(3/4, contentMode: .fill) // Displays the loaded image.
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if phase.error != nil {
                    ProgressView()
                        .frame(width: 150, height: 200)
                        .border(Color.white)
                        .background(Color("ImageBackgroundPlaceholder"))
                } else {
                    EmptyView()
                }
                
                Text(manga.title + "\n")
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
