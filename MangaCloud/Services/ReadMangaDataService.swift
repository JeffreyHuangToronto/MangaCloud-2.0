//
//  ReadMangaDataService.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-11.
//

import Foundation
import CoreData

class ReadMangaDataService {
    let container: NSPersistentContainer
    let containerName: String  = "ChapterReadContainer"
    let entityName: String = "ChapterReadEntity"
    
    @Published var savedEntities: [ChapterReadEntity] = []
    
    //    var container: NSPersistentContainer
    ////        let container = NSPersistentContainer(name: "ChapterReadContainer")
    ////        container.loadPersistentStores { description, error in
    ////            if let error = error {
    ////                fatalError("Unable to load persistent stores: \(error)")
    ////            }
    ////        }
    ////        return container
    //    }()
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getReadStatus()
        }
    }
    // MARK: PUBLIC
    
    func addToReadHistory(_ mangaId: String, _ chapterIndex: Int) {
        //        if let entity = savedEntities.first(where: {$0.mangaId == mangaId}){
        //            print("I found you in my history")
        //            if (chapterIndex > entity.read){
        //                print("Updating the read history-------------")
        //                delete(entity: entity)
        //                add(mangaId, Int64(chapterIndex))
        //                print("ADDED!! ------------------------------")
        //            }
        //        }
        //        else{
        //            print("It seems like I don't have you in my history! \(mangaId) \(chapterIndex)")
        //            add(mangaId, Int64(chapterIndex))
        //        }
        let entity = savedEntities.filter({ ent in
            ent.mangaId == mangaId
        })
        
        entity.forEach { ent in
            delete(entity: ent)
            if (chapterIndex > ent.read){
                add(mangaId, Int64(chapterIndex))
            }
        }
        if entity.count == 0 {
            add(mangaId, Int64(chapterIndex))
        }
        
        
        
        print("Completed Add to History Call")
        self.getReadStatus()
    }
    
    func removeReadChapter(_ mangaId: String){
        if let entity = savedEntities.first(where: {$0.mangaId == mangaId}){
            delete(entity: entity)
        }
        self.getReadStatus()
    }
    
    // MARK: PRIVATE
    
    func getReadStatus() {
        let request = NSFetchRequest<ChapterReadEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching ReadEntities. \(error)")
        }
        print("Fetched Read Status!")
    }
    
    private func add(_ mangaId: String, _ chapterIndex: Int64) {
        let entity = ChapterReadEntity(context: container.viewContext)
        entity.mangaId = mangaId
        entity.read = chapterIndex
        applyChanges()
    }
    
    private func delete(entity: ChapterReadEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data! \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getReadStatus()
    }
}
