//
//  Api.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-29.
//

import Foundation

class Api{
    func getMangaChapter(manga_id: String, chapter_name: Double, completion: @escaping (MangaChapter) -> ()){
                guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())") else { return }
//        guard let url = URL(string: "http://localhost:8080/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())") else {
//            return
//        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if (data != nil){
                let chapter = try! JSONDecoder().decode(MangaChapter.self, from: data!)
                DispatchQueue.main.async {
                    completion(chapter)
                }
            }
        }
        .resume()
    }
    
    func getLatestChapters(completion: @escaping (LatestMangaList) -> ()){
        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/latest") else { return }
//        guard let url = URL(string: "http://localhost:8080/manga/latest") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if (data != nil){
                let chapter = try! JSONDecoder().decode(LatestMangaList.self, from: data!)
                DispatchQueue.main.async {
                    completion(chapter)
                }
            }
        }
        .resume()
    }
}

