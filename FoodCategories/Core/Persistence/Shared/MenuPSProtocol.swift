//
//  MenuPSProtocol.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 19/09/2025.
//

// Menu Persistence Service Protocol
protocol MenuPSProtocol {
    func save(menu: MenuModel) async throws
    func replace(menu: MenuModel) async throws
    func get() async throws -> MenuModel?
    func clean() async throws
}
