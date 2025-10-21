//
//  DrinkPS.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 20/09/2025.
//


// Drink Persistence Service
protocol DrinkPS {
    func getAll() async throws -> [DrinkModel]
    func add(item: DrinkModel) async throws
    func add(items: [DrinkModel]) async throws
    func delete(item: DrinkModel) async throws
    func deleteAll() async throws
}
