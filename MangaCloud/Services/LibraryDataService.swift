//
//  LibraryDataService.swift
//  MangaCloud
//
//  Created by Jeffrey Huang on 2022-01-08.
//

import Foundation
import CoreData

class LibraryDataService {
    let container: NSPersistentContainer
    let containerName: String  = "LibraryContainer"
    let entityName: String = "LibraryEntity"
    
    @Published var savedEntities: [LibraryEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getLibrary()
        }
    }
    // MARK: PUBLIC
    
    func addToLibrary(_ mangaId: String) {
        if let entity = savedEntities.first(where: {$0.mangaId == mangaId}){
            delete(entity: entity)
        } else {
            add(mangaId)
        }
        self.getLibrary()
    }
    
    // MARK: PRIVATE
    
    private func getLibrary() {
        let request = NSFetchRequest<LibraryEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching LibraryEntities. \(error)")
        }
    }
    
    private func add(_ mangaId: String) {
        let entity = LibraryEntity(context: container.viewContext)
        entity.mangaId = mangaId
        applyChanges()
    }
    
    private func delete(entity: LibraryEntity) {
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
        getLibrary()
    }
}
