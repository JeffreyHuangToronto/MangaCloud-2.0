//
//  MangaInfoView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-31.
//

import SwiftUI

struct MangaView: View {
    let viewModel: MangaViewModel
    @EnvironmentObject var libraryViewModel: LibraryViewModel
    
    @State private var toggle = true
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text(viewModel.getTitle())
                AsyncImage(url: URL(string: viewModel.getCoverUrl())){ image in
                    image
                        .resizable()
                        .frame(idealWidth: 150, maxWidth: 200, idealHeight: 250, maxHeight: 250)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(viewModel.getSummary())
                    .lineLimit(toggle ? 2 : nil)
                    .foregroundColor(Color(.label))
                    .padding(10)
                    .onTapGesture {
                        toggle.toggle()
                    }
                
                if (libraryViewModel.isFavorited(_id: viewModel.getId()))
                {
                    Button
                    {
                        libraryViewModel.updateSavedLibrary(viewModel.getId())
                    } label: {
                        Image(systemName: "bookmark.fill")
                    }
                } else {
                    Button
                    {
                        libraryViewModel.updateSavedLibrary(viewModel.getId())
                    } label: {
                        Image(systemName: "bookmark")
                    }
                }
                

                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 100))])
                {
                    ForEach(0..<viewModel.getChapterNames().count)
                    { index in
                        NavigationLink {
                            ChapterView(manga: viewModel.getManga(), chapter_index: index)
                                .navigationBarHidden(true)
                        }
                    label:
                        {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(ThemeSettings.primaryColor)
                                .frame(width: 75, height: 50)
                                .overlay {
                                Text("\(viewModel.getChapterNames()[index].removeZerosFromEnd())")
                                        .foregroundColor(ThemeSettings.textColor)
                                        .shadow(color: ThemeSettings.primaryColor, radius: 5, x: 0, y: 0)
                            }
                            
                        }
                        .isDetailLink(false)
                }
            }
    }
        
        }
    }
}


struct MangaInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        let manga = MangaItem(_id: "", title: "Title", summary: "Summary", cover_url: "", chapter_names: [])
        let viewModel = MangaViewModel(manga: manga)
        MangaView(viewModel: viewModel)
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
}
