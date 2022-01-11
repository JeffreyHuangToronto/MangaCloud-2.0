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
    
//    var chapter_index: Int
    
    
    @State var toggle = false
    
    init(manga: MangaItem, chapter_index: Int){
        viewModel = ChapterViewModel(manga: manga, chapter_index: chapter_index)
        
        print("Initializing Chapter for: \(manga.title) \(chapter_index)")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                let urls = viewModel.getChapterUrls()
                if (!viewModel.isLoaded()){
                    Text("Loading Chapter\n Please Wait")
                }
                else{
                    ForEach(urls, id: \.self){ i in
                        AsyncImage(url: URL(string: i))
                        { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onTapGesture {
            withAnimation {
                toggle.toggle()
                print("Toggle \(toggle)")
            }
        }
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

                                    viewModel.goBack()
                                } label: {
                                    Image(systemName: "text.justify")
//                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ThemeSettings.largeIconSize, height: ThemeSettings.largeIconSize)
                                        .tint(ThemeSettings.buttonColor)
                                }
                                Spacer()
                                Button
                                {
                                    viewModel.goNext()
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
        ChapterView(manga: dev.manga, chapter_index: 0)
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


