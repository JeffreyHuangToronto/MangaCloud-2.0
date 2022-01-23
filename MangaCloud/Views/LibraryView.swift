//
//  LibraryView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-06.
//

import SwiftUI

struct LibraryView: View {
    //    @EnvironmentObject var viewModel: LibraryViewModel
    @ObservedObject var viewModel: LibraryViewModel
    
    @State private var selectedManga: MangaItem? = nil
    @State private var showDetailView: Bool = false
    
    
    init(){
        print("Library View")
        viewModel = LibraryViewModel()
    }
    
    @ObservedObject private var user = UserModel.instance
    var body: some View {
        let library = viewModel.getLibrary()
        ZStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250))]){
                    ForEach(library, id: \.self) { manga in
                        MangaItemView(manga: manga).onTapGesture {
                            segue(manga: manga)
                        }
                    }
                }
            }
            .background(content: {
                NavigationLink(isActive: $showDetailView) {
                    MangaDetailView(manga: $selectedManga)
                } label: {
                    EmptyView()
                }
            })
            .navigationBarHidden(true)
            if (library.isEmpty){
                VStack {
                    Text("Your library is Empty")
                        .font(Font.largeTitle.weight(.bold))
                    Text("Bookmark some manga!")
                }
            }
        }
        //        }
    }
    
    private func segue(manga: MangaItem){
        selectedManga = manga
        showDetailView.toggle()
    }
}

struct LibraryView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        LibraryView().environmentObject(dev.userLibraryViewModel)
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
