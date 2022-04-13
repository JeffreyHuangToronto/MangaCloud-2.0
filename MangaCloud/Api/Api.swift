//
//  Api.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2021-12-29.
//

import Foundation
import SwiftUI

class Api{
    
    @ObservedObject var user = UserModel.instance
    
//    let URL = "http://localhost:8080"
    let URL = "https://manga-cloud-api.herokuapp.com"
    
    func getMangaChapter(manga_id: String, chapter_name: Double, completion: @escaping (MangaChapter) -> ()){
        let request = URLRequest(url: NSURL(string: "\(URL)/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())")! as URL)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if (data != nil){
                let chapter = try! JSONDecoder().decode(MangaChapter.self, from: data!)
                DispatchQueue.main.async {
//                    print(chapter)
                    completion(chapter)
                }
            }
        }
        .resume()
    }
    
    func search(_ query: String, completion: @escaping (SearchItem) -> ()){
        let request = NSMutableURLRequest(url: NSURL(string: "\(URL)/manga/search?title=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, _ in
            if (data != nil){
                let search = try! JSONDecoder().decode(SearchItem.self, from: data!)
                DispatchQueue.main.async {
                    completion(search)
                }
            }
        }
        .resume()
    }
    
    func getLatestChapters(completion: @escaping (LatestMangaList) -> ()){
        let request = NSMutableURLRequest(url: NSURL(string: "\(URL)/manga/latest")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, _ in
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
        let headers = ["Content-Type": "application/json"]
        let parameters = ["library": mangaIdList] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(URL)/manga/library")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)

        request.httpMethod = "POST"
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers
//        request.addValue("Bearer \(user.accessToken)", forHTTPHeaderField: "Authorization")

        
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, _ in
            if (data != nil){
                let libraryList = try! JSONDecoder().decode(Library.self, from: data!)
                DispatchQueue.main.async {
                    completion(libraryList)
                }
            }
        }
        .resume()
    }
}

struct SearchItem: Decodable {
    var total: Int
    var result: [MangaItem]
}
