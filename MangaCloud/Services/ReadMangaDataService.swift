//
//  ReadMangaDataService.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-11.
//

import Foundation
import CoreData

class ReadMangaDataService: ObservableObject {
    let container: NSPersistentContainer
    let containerName: String  = "ChapterReadContainer"
    let entityName: String = "ChapterReadEntity"
    
    static let sharedInstance = ReadMangaDataService()
    
    
    
    @Published var savedEntities: [ChapterReadEntity] = []
//    @Published var refreshToggle: Bool = false
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getReadHistory()
        }
    }
    // MARK: PUBLIC
    
//    func refreshView() {
//        print("Toggling")
//        refreshToggle.toggle()
//    }
    
    func getMangaChapterReadStatus(_ mangaId: String) -> Int?{
        if let entity = savedEntities.first(where: { $0.mangaId == mangaId }) {
            return Int(entity.read)
        } else {
            return nil
        }
    }
    
    func clearAllReadStatus(){
        // create the delete request for the specified entity
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ChapterReadEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        // get reference to the persistent container
        let persistentContainer = container

        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func setMangaChapterReadStatus(_ mangaId: String, _ chapterIndex: Int) {
        if (chapterIndex != -1){
            if let entity = savedEntities.first(where: {$0.mangaId == mangaId}){
                // Found the entity in storage
                // Let's see if we should update it
                if (chapterIndex > entity.read){ // We are on a chapter higher than what was stored
                    // Let's update it
                    entity.setValue(chapterIndex, forKey: "read")
                    applyChanges()
                }
            }
            else {
                // Otherwise if not found add it
                add(mangaId, Int64(chapterIndex))
            }
        }
        getReadHistory()
    }
    
    func removeReadChapter(_ mangaId: String){
        if let entity = savedEntities.first(where: {$0.mangaId == mangaId}){
            delete(entity: entity)
        }
        getReadHistory()
    }
    
    // MARK: PRIVATE
    
    func getReadHistory() {
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
        getReadHistory()
    }
}
