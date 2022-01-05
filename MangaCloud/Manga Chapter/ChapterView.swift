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
    
    @State var toggle = false
    
    init(manga: MangaItem, chapter_index: Int){
        viewModel = ChapterViewModel(manga: manga, chapter_index: chapter_index)
    }
    
    var body: some View {
        ScrollView {
            //            VStack{
            let urls = viewModel.getChapterUrls()
            if (!viewModel.isLoaded()){
                Text("Loading Chapter\n Please Wait")
            }
            else{
                VStack {
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
            //            }
            //            .frame(width: UIScreen.main.bounds.width)
        }
        .onTapGesture {
            toggle.toggle()
            print("Toggle \(toggle)")
        }
        .overlay(alignment: .bottom) {
            if (toggle){
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .overlay(alignment: .top) {
                        VStack {
                            Text("Chapter \(viewModel.getChapterName().removeZerosFromEnd())")
                            HStack {
                                Button("GO BACK"){
                                    viewModel.goBack()
                                }
                                Button("GO NEXT"){
                                    viewModel.goNext()
                                }
                            }
                        }
                    }
                
            }
            else {
                EmptyView()
            }
        }
        .overlay(alignment: .topLeading, content: {
            if (toggle){
                Button("<"){
                    dismiss()
                }
                .containerShape(Rectangle())
                .frame(width: 30, height: 30, alignment: .topLeading)
                .padding(15)
                .font(.largeTitle)
            }
            else {
                EmptyView()
            }
        })
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChapterView(manga: MangaItem(_id: "", title: "",summary: "", cover_url: "", chapter_names: Array<Double>()), chapter_index: 0)
    }
}

