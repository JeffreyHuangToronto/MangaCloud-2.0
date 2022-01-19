//
//  MangaInfoView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-31.
//

import SwiftUI

struct MangaDetailView: View {
    @ObservedObject var viewModel: MangaViewModel
    @EnvironmentObject var libraryViewModel: LibraryViewModel
    @Binding var manga: MangaItem?
    
    @ObservedObject var chapterViewModel: ChapterViewModel
    
    private var readMangaDataService = ReadMangaDataService.sharedInstance
    
    @State private var selectedChapterIndex: Int = -1
    @State private var showDetailView: Bool = false
    @State private var toggle = true
    
    init(manga: Binding<MangaItem?>){
        self._manga = manga
        print("Initializing Detail View for: \(manga.wrappedValue?.title ?? "Title")")
        viewModel = MangaViewModel(manga: MangaItem(_id: manga.wrappedValue?._id ?? "", title: manga.wrappedValue?.title ?? "", summary: manga.wrappedValue?.summary ?? "", cover_url: manga.wrappedValue?.cover_url ?? "", chapter_names: manga.wrappedValue?.chapter_names ?? []))
        chapterViewModel = ChapterViewModel(manga: MangaItem(_id: manga.wrappedValue?._id ?? "", title: manga.wrappedValue?.title ?? "", summary: manga.wrappedValue?.summary ?? "", cover_url: manga.wrappedValue?.cover_url ?? "", chapter_names: manga.wrappedValue?.chapter_names ?? []), chapter_index: -1)
//        print(chapterViewModel.manga)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack(alignment: .center){
                        coverImage
                        title
                    }
                    actionBar
                    summary
                    chapters
                }
                .background(alignment: .top){
                    bannerImage
                }
            }
            .background(content: {
                NavigationLink(isActive: $showDetailView) {
                    ChapterView(manga: manga!, chapter_index: selectedChapterIndex, chapterViewModel)
                } label: {
                    EmptyView()
                }
            })
        }
        .navigationBarHidden(false)
        
    }
    
    private func segue(manga: MangaItem, chapterIndex: Int) {
        print("segue: \(chapterIndex)")
        selectedChapterIndex = chapterIndex
        readMangaDataService.setMangaChapterReadStatus(viewModel.getId(), chapterIndex)
        chapterViewModel.setChapterIndex(chapterIndex)
        chapterViewModel.updateChapterUrls()
        showDetailView.toggle()
    }
    
    // MARK: USER INTERFACE ITEMS
    
    private var bannerImage: some View {
        AsyncImage(url: URL(string: viewModel.getCoverUrl())) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .blur(radius: 10, opaque: false)
                .frame(height: ThemeSettings.heroHeight)
                .ignoresSafeArea()
                .border(Color.red)
                .background(.regularMaterial)
                .brightness(-0.2)
                .clipped()
                .offset(x: 0, y: -50)
        } placeholder: {
            ProgressView()
        }
    }
    
    private var coverImage: some View {
        AsyncImage(url: URL(string: viewModel.getCoverUrl())) { image in
            image
                .resizable()
                .aspectRatio(3/4, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 3)
                )
        } placeholder: {
            ProgressView()
        }
        .padding(.top, 75)
        .padding(.leading,ThemeSettings.normalPadding)
    }
    
    private var title: some View {
        Text(viewModel.getTitle())
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(ThemeSettings.largeTitleColor)
            .padding(Edge.Set.top, ThemeSettings.normalPadding)
    }
    
    // Summary
    private var summary: some View {
        Text(viewModel.getSummary())
            .lineLimit(toggle ? 2 : nil)
            .foregroundColor(Color(.label))
            .padding(Edge.Set.leading, ThemeSettings.normalPadding)
            .onTapGesture {
                toggle.toggle()
            }
    }
    
    // Chapter Buttons
    private var chapters: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
            ForEach(0..<viewModel.getChapterNames().count) { index in
                RoundedRectangle(cornerRadius: 5)
                    .fill(ThemeSettings.primaryColor)
                    .frame(width: 90, height: 45)
                    .overlay {
                        Text("\(viewModel.getChapterNames()[index].removeZerosFromEnd())")
                            .foregroundColor(ThemeSettings.textColor)
                    }
                    .onTapGesture {
                        segue(manga: manga!, chapterIndex: index)
                    }
            }
        }
    }
    
    // Favorite bar, last read
    private var actionBar: some View {
        HStack(alignment: VerticalAlignment.top)
        {
            let isFav = libraryViewModel.isFavorited(_id: viewModel.getId())
            Button {
                libraryViewModel.updateSavedLibrary(viewModel.getId())
            } label: {
                Image(systemName: isFav ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                    .tint(ThemeSettings.buttonColor)
                
            }
            Spacer()
            let _id = viewModel.getId()
            let readStatus = readMangaDataService.getMangaChapterReadStatus(_id)
            let chapterNames = viewModel.getChapterNames()
            
            Button(readStatus != nil ? "Continue Reading Chapter: \(chapterNames[readStatus!].removeZerosFromEnd())" : "Start reading"){
                segue(manga: viewModel.getManga(), chapterIndex: readStatus != nil ? readStatus! : 0)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .padding(.leading, ThemeSettings.normalPadding)
        .padding(.trailing, ThemeSettings.normalPadding)
    }
}


struct MangaInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        MangaDetailView(manga: .constant(dev.manga)).environmentObject(dev.userLibraryViewModel)
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
    static let heroHeight: Double = Double(UIScreen.main.bounds.height / 3)
}
