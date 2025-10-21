//
//  MenuModel.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//

struct MenuModel: Codable {
    var hamburgers: [HamburgerModel]?
    var pasta: [PastaModel]?
    var drinks: [DrinkModel]?
    var sandwiches: [SandwichModel]?
    func isEmpty() -> Bool {
        return (hamburgers?.isEmpty ?? true) && (pasta?.isEmpty ?? true) && (drinks?.isEmpty ?? true) && (sandwiches?.isEmpty ?? true)
    }
}
