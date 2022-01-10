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
            
            ZStack(alignment: Alignment.top) {
                VStack{
                    AsyncImage(url: URL(string: viewModel.getCoverUrl())) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                            
                            .blur(radius: 10, opaque: false)
                            .frame(height: ThemeSettings.heroHeight)
                            .ignoresSafeArea()
                            .background(.regularMaterial)
                            .brightness(-0.2)
                            .clipped()
                            
                            
                    } placeholder: {
                        ProgressView()
                    }
                    
                    .edgesIgnoringSafeArea(Edge.Set.top)
                   

                }
                .edgesIgnoringSafeArea(Edge.Set.top)
                
                LazyVStack {
                    VStack {
                        Spacer()
                        HStack {
                            AsyncImage(url: URL(string: viewModel.getCoverUrl())) { image in
                                image
                                    .resizable()
//                                    .frame(idealWidth: 150, maxWidth: 200, idealHeight: 300, maxHeight: 300)
                                    .aspectRatio(3/4, contentMode: .fit)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                        .stroke(Color.white, lineWidth: 3)
                                    )
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                            .padding(ThemeSettings.normalPadding)
                            .padding(.leading, 30)
                            VStack {
                                Spacer()
                                HStack{
                                    Text(viewModel.getTitle())
                                        .fontWeight(.bold)
//                                        .font(.system(size: ,weight: .bold, design: .rounded))
                                        .fontWeight(.bold)
//                                        .font(.Design.rounded)
                                        .font(.title)
                                        .foregroundColor(ThemeSettings.largeTitleColor)
        //                                .frame(width: 500, height: 250, alignment: .topLeading)
                                        .padding(Edge.Set.top, ThemeSettings.normalPadding)
                                    Spacer()
                                }
                                
                                Spacer()
                                HStack
                                {
                                    if (libraryViewModel.isFavorited(_id: viewModel.getId()))
                                    {
                                        Button
                                        {
                                            libraryViewModel.updateSavedLibrary(viewModel.getId())
                                        } label: {
                                            Image(systemName: "bookmark.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                                                .tint(ThemeSettings.buttonColor)
                                                .padding(10)
                                        }
                                    } else {
                                        Button
                                        {
                                            libraryViewModel.updateSavedLibrary(viewModel.getId())
                                        } label: {
                                            Image(systemName: "bookmark")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ThemeSettings.iconSize, height: ThemeSettings.iconSize)
                                                .tint(ThemeSettings.buttonColor)
                                                .padding(10)
                                        }
                                    }
                                    Spacer()
                                }
                                
                            }
                            Spacer()
                        }
                        Text(viewModel.getSummary())
                            .lineLimit(toggle ? 2 : nil)
                            .foregroundColor(Color(.label))
                            .padding(10)
                            .padding(Edge.Set.leading, ThemeSettings.normalPadding)
                            .onTapGesture {
                                toggle.toggle()
                            }
                    
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
                            ForEach(0..<viewModel.getChapterNames().count) { index in
                                NavigationLink {
                                    ChapterView(manga: viewModel.getManga(), chapter_index: index)
                                        .navigationBarHidden(true)
                                } label: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(ThemeSettings.primaryColor)
                                        .frame(width: 90, height: 45)
    //                                    .padding(ThemeSettings.normalPadding)
                                        .overlay {
                                            Text("\(viewModel.getChapterNames()[index].removeZerosFromEnd())")
                                                .foregroundColor(ThemeSettings.textColor)
    //                                            .shadow(color: ThemeSettings.primaryColor, radius: 5, x: 0, y: 0)
                                        }
                                }
                                .isDetailLink(false)

                            }
                        }
                    }
                    
                }
            }
            
        }
//        .overlay(alignment: .topTrailing){
//            HStack {
//                Spacer()
//
//            }
//        }
    }
}
    
    
struct MangaInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = MangaViewModel(manga: dev.manga)
        MangaView(viewModel: viewModel).environmentObject(dev.userLibraryViewModel)
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
