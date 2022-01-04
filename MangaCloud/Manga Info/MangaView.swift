//
//  MangaInfoView.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-31.
//

import SwiftUI

struct MangaView: View {
    let viewModel: MangaViewModel
    
    @State private var toggle = true
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.getTitle())
                Text(viewModel.getCoverUrl())
                AsyncImage(url: URL(string: viewModel.getCoverUrl())){ image in
                    image
                        .resizable()
                        .frame(idealWidth: 150, maxWidth: 200, idealHeight: 250, maxHeight: 250)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(viewModel.getSummary())
                    .lineLimit(toggle ? 2 : nil)
                    .foregroundColor(.black)
                    .padding(10)
                    .onTapGesture {
                        toggle.toggle()
                }
                
                ForEach(0..<viewModel.getChapterNames().count){ index in
                    NavigationLink {
                        ChapterView(manga: viewModel.getManga(), chapter_index: index)
                            .navigationBarHidden(true)
                    } label: {
                        Text("Test Chapter \(viewModel.getChapterNames()[index].removeZerosFromEnd())")
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
