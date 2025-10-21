//
//  CRUDParent.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 19/09/2025.
//


import CoreData

protocol CRUDParent {
    associatedtype Model: AppModel
    associatedtype Entity: NSManagedObject & CDEntityToModelConverter where Entity.T == Model
}

extension CRUDParent {
    @MainActor
    func getAll() async throws -> [Model] {
        let request: NSFetchRequest<Entity> = Entity.fetch()
        let data = try CoreDataCore.shared.viewContext.fetch(request)
        return data.map { $0.convert() }
    }
    
    func add(item: Model) async throws {
        try await CoreDataCore.shared.performBackgroundTask { context in
            _ = Entity.initialize(context: context, with: item)
            try context.save()
        }
    }
    
    func add(items: [Model]) async throws {
        try await CoreDataCore.shared.performBackgroundTask { context in
            for item in items {
                _ = Entity.initialize(context: context, with: item)
            }
            try context.save()
        }
    }
    
    func delete(item: Model) async throws {
        
    }
    
    func deleteAll() async throws {
        try await CoreDataCore.shared.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Entity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            try context.save()
        }
    }
}
