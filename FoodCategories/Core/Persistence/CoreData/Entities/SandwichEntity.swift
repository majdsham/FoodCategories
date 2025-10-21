//
//  SandwichEntity.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 20/09/2025.
//


import CoreData

final public class SandwichEntity: MenuOptionEntity, CDEntityToModelConverter {
    typealias T = SandwichModel
    
    func convert() -> SandwichModel {
        .init(id: Int(id), name: name, price: price, description: itemDescription, vegan: vegan, hot: hot, rating: rating, image: image, available: available)
    }
    
    static func initialize(context moc: NSManagedObjectContext, with model: SandwichModel) -> Self {
        let newEntity = Self(context: moc)
        newEntity.id = Int64(model.id)
        newEntity.name = model.name
        newEntity.price = model.price ?? 0
        newEntity.itemDescription = model.description
        newEntity.vegan = model.vegan ?? false
        newEntity.hot = model.hot ?? false
        newEntity.rating = model.rating ?? 0
        newEntity.image = model.image
        newEntity.available = model.available ?? false
        return newEntity
    }
}
