//
//  MenuCategory.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import Foundation

public enum MenuCategory: String, CaseIterable, Identifiable {
    case hamburgers = "Hamburgers"
    case pasta = "Pasta"
    case drinks = "Drinks"
    case sandwiches = "Sandwiches"

    public var id: String { rawValue }
}
