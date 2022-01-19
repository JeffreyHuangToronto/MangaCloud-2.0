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
    
    func getLibraryMangaList(mangaIdList: Array<String>, completion: @escaping (Library) -> ()){
//        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/") else { return }
        //        guard let url = URL(string: "http://localhost:8080/manga/latest") else { return }
        
        let headers = ["Content-Type": "application/json"]
        let parameters = ["library": mangaIdList] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mangacloudapi.azurewebsites.net/manga/library")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
//        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/manga/library")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, _ in
            if (data != nil){
                let libraryList = try! JSONDecoder().decode(Library.self, from: data!)
                DispatchQueue.main.async {
//                    print("Library: \(libraryList)")
                    completion(libraryList)
                }
            }
        }
        .resume()
    }
}

