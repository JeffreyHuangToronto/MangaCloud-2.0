//
//  ChapterView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-27.
//

import SwiftUI

struct ChapterView: View {
    @ObservedObject var viewModel: ChapterViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var progress: Float = 1
    
    // TODO: To be moved to settings
    @State var spacingBetweenImages: CGFloat = 0
    @State var toggleChapterList = false
    @State var sensitivity = 0.0
    
    
    @State var lastScaleValue: CGFloat = 1.0
    private var libraryDataService = LibraryDataService.sharedInstance
    private var readMangaDataService = ReadMangaDataService.sharedInstance
    
    @State var toggle = false
    
    init(manga: MangaItem, chapter_index: Int, _ vm: ChapterViewModel){
        print("Initializing Chapter for: \(manga.title) \(chapter_index)")
        viewModel = vm
        if (chapter_index != -1){
            readMangaDataService.setMangaChapterReadStatus(manga._id, chapter_index)
        }
    }
    
    init(manga: MangaItem, chapter_index: Int){
        print("Chapter for: \(manga.title) \(chapter_index)")
        viewModel = ChapterViewModel(manga: manga, chapter_index: chapter_index)
        if (chapter_index != -1){
            readMangaDataService.setMangaChapterReadStatus(manga._id, chapter_index)
        }
    }
    
    
    
    var body: some View {
        
        ScrollView {
//            Slider(
//                    value: $sensitivity,
//                    in: 0...Double(viewModel.manga.chapter_names.count),
//                    step: 1
//                ) {
//                    Text("Speed")
//                } minimumValueLabel: {
//                    Text("\(viewModel.manga.chapter_names[0].removeZerosFromEnd())")
//                } maximumValueLabel: {
////                    Text("100")
//                    Text("\(viewModel.manga.chapter_names[viewModel.manga.chapter_names.count - 1].removeZerosFromEnd())")
//                }
//            Text("Chapter: \(viewModel.manga.chapter_names[])")
                        VStack(spacing: spacingBetweenImages) {
                            let urls = viewModel.getChapterUrls()
                            if (viewModel.progress != 4){
                                VStack{
                                    Text("Loading Chapter\n Please Wait")
                                        .font(Font.largeTitle.weight(.bold))
                                    ProgressView("Loading", value: viewModel.progress, total: 4).padding(15)
                                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                            }
                            if (viewModel.progress == 4){
                                ForEach(urls, id: \.self){ i in
                                    AsyncImage(url: URL(string: i))
                                    { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        ProgressView().progressViewStyle(.circular)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                        .statusBar(hidden: !toggle)
        }
        
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onTapGesture {
            withAnimation {
                toggle.toggle()
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .overlay(alignment: .bottom) {
            if (toggle){
                Rectangle()
                    .fill(ThemeSettings.primaryColor)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(height: ThemeSettings.bottomBarHeight)
                    .opacity(ThemeSettings.menuOpacity)
                    .transition(.move(edge: .bottom))
                    .overlay(alignment: .top) {
                        VStack {
                            HStack {
                                Button
                                {
                                    viewModel.goBack()
                                } label: {
                                    Image(systemName: "backward.end")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                                        .tint(ThemeSettings.buttonColor)
                                }
                                Spacer()
                                Button
                                {
                                    //                                    viewModel.goBack()
                                    toggleChapterList.toggle()
                                } label: {
                                    Image(systemName: "text.justify")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ThemeSettings.largeIconSize, height: ThemeSettings.largeIconSize)
                                        .tint(ThemeSettings.buttonColor)
                                }
                                
                                Spacer()
                                Button
                                {
                                    viewModel.goNext()
                                    readMangaDataService.setMangaChapterReadStatus(viewModel.manga._id,viewModel.getChapterIndex())
                                } label: {
                                    Image(systemName: "forward.end")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                                        .tint(ThemeSettings.buttonColor)
                                    
                                }
                            }
                            .padding(40)
                        }
                    }
                
            }
            else {
                EmptyView()
            }
        }
        
        // Top Bar
        .overlay(alignment: .topLeading, content: {
            if (toggle){
                
                Rectangle()
                    .fill(ThemeSettings.primaryColor)
                    .frame(height: ThemeSettings.topBarHeight)
                    .opacity(ThemeSettings.menuOpacity)
                    .transition(.move(edge: .top))
                // Status Bar Color
                    .overlay(alignment: .top) {
                        ThemeSettings.primaryColor
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                        
                    }
                    .overlay(alignment: .center) {
                        
                        HStack {
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                            }
                            .containerShape(Rectangle())
                            .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                            .padding(15)
                            .font(.largeTitle)
                            .tint(ThemeSettings.buttonColor)
                            
                            Spacer()
                            
                            VStack(alignment: HorizontalAlignment.leading){
                                
                                Text("\(viewModel.getTitle())")
                                    .foregroundColor(ThemeSettings.textColor)
                                    .fontWeight(.bold)
                                Text("Ch. \(viewModel.getChapterName().removeZerosFromEnd())")
                                    .foregroundColor(ThemeSettings.textColor)
                                
                            }
                            //
                            
                            
                            Spacer()
                            Button
                            {
                                
                                
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                                    .tint(ThemeSettings.buttonColor)
                                    .padding(10)
                            }
                            iconButton()
                        }
                        .padding(15)
                        
                        
                    }
            }
            else {
                EmptyView()
            }
        })
        
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(manga: dev.manga, chapter_index: 0, dev.chapterViewModel)
    }
}

struct iconButton: View {
    var body: some View {
        Button
        {
            
        } label: {
            Image(systemName: "bookmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                .tint(ThemeSettings.buttonColor)
                .padding(10)
        }
    }
}

private struct ThemeSettings {
    static let primaryColor: Color = Color(UIColor.systemBackground)
    static let secoundaryColor: Color = Color(UIColor.systemBackground)
    static let textColor: Color = Color(UIColor.label)
    static let buttonColor: Color = Color(UIColor.label)
    static let iconSize: CGFloat = 20
    static let largeIconSize: CGFloat = 30
    static let menuOpacity: Double = 0.8
    static let topBarHeight: Double = 100
    static let topBarWidth: Double = .infinity
    static let bottomBarHeight: Double = 75
}


