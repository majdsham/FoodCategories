//
//  SandwichPS.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 20/09/2025.
//

// Sandwich Persistence Service
protocol SandwichPS {
    func getAll() async throws -> [SandwichModel]
    func add(item: SandwichModel) async throws
    func add(items: [SandwichModel]) async throws
    func delete(item: SandwichModel) async throws
    func deleteAll() async throws
}
