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
    
    func getMangaChapter(manga_id: String, chapter_name: Double, completion: @escaping (MangaChapter) -> ()){
//        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())") else { return }
        //        guard let url = URL(string: "http://localhost:8080/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())") else {
        //            return
        //        }
        
        let request = URLRequest(url: NSURL(string: "https://mangacloudapi.azurewebsites.net/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())")! as URL)
        
//        print("https://mangacloudapi.azurewebsites.net/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())")
//        request.addValue("Bearer \(user.accessToken)", forHTTPHeaderField: "Authorization")
        
//        print(request)
        
        
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
//        print("https://mangacloudapi.azurewebsites.net/manga/search?title=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")
//        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/search?title=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)") else { return }
        //        guard let url = URL(string: "http://localhost:8080/manga/\(manga_id)/\(chapter_name.removeZerosFromEnd())") else {
        //            return
        //        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mangacloudapi.azurewebsites.net/manga/search?title=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
//        request.addValue("Bearer \(user.accessToken)", forHTTPHeaderField: "Authorization")
        
        
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
//        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/latest") else { return }
        //        guard let url = URL(string: "http://localhost:8080/manga/latest") else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mangacloudapi.azurewebsites.net/manga/latest")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
//        request.addValue("Bearer \(user.accessToken)", forHTTPHeaderField: "Authorization")
        
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
        //        guard let url = URL(string: "https://mangacloudapi.azurewebsites.net/manga/") else { return }
        //        guard let url = URL(string: "http://localhost:8080/manga/latest") else { return }
        
        let headers = ["Content-Type": "application/json"]
        let parameters = ["library": mangaIdList] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mangacloudapi.azurewebsites.net/manga/library")! as URL,
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
