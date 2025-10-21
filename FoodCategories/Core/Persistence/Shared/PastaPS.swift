//
//  PastaPS.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 20/09/2025.
//

// Pasta Persistence Service
protocol PastaPS {
    func getAll() async throws -> [PastaModel]
    func add(item: PastaModel) async throws
    func add(items: [PastaModel]) async throws
    func delete(item: PastaModel) async throws
    func deleteAll() async throws
}
