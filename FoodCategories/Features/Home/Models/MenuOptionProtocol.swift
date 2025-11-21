//
//  MenuOptionProtocol.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//

public protocol AppModel: Codable {
    
}

public protocol MenuOptionProtocol: AppModel, Identifiable, Hashable {
    var id: Int { get }
    var name: String? { get }
    var price: Double? { get }
    var description: String? { get }
    var vegan: Bool? { get }
    var hot: Bool? { get }
    var rating: Double? { get }
    var image: String? { get }
    var available: Bool? { get }
}
