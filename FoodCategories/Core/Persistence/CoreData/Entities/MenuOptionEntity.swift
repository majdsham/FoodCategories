//
//  MenuOptionEntity.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 14/09/2025.
//

import CoreData

protocol CDEntityToModelConverter: EntityToModelConverter where Self: NSManagedObject {
    static func initialize(context moc: NSManagedObjectContext, with model: T) -> Self
    static func fetch() -> NSFetchRequest<Self>
}

extension CDEntityToModelConverter {
    static func fetch() -> NSFetchRequest<Self> {
        // This assumes the entity name in your Core Data model matches the class name.
        return NSFetchRequest<Self>(entityName: String(describing: self))
    }
}

public class MenuOptionEntity: NSManagedObject {
    @NSManaged public var available: Bool
    @NSManaged public var hot: Bool
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var rating: Double
    @NSManaged public var vegan: Bool
}
