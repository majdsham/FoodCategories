//
//  HamburgerPS.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 18/09/2025.
//

// Hamburger Persistence Service
protocol HamburgerPS {
    func getAll() async throws -> [HamburgerModel]
    func add(item: HamburgerModel) async throws
    func add(items: [HamburgerModel]) async throws
    func delete(item: HamburgerModel) async throws
    func deleteAll() async throws
}
