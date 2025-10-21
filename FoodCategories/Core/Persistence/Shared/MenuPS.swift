//
//  MenuPS.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 19/09/2025.
//

//Menu Persistence Service
final class MenuPS: MenuPSProtocol {
    
    private let hamburgerService: HamburgerPS
    private let pastaService: PastaPS
    private let sandwichService: SandwichPS
    private let drinksService: DrinkPS
    
    init(
        hamburgerService: HamburgerPS = CDHamburgerPS(),
        pastaService: PastaPS = CDPastaPS(),
        sandwichService: SandwichPS = CDSandwichPS(),
        drinksService: DrinkPS = CDDrinkPS()
    ) {
        self.hamburgerService = hamburgerService
        self.pastaService = pastaService
        self.sandwichService = sandwichService
        self.drinksService = drinksService
    }
    
    func clean() async throws {
        try await hamburgerService.deleteAll()
        try await pastaService.deleteAll()
        try await sandwichService.deleteAll()
        try await drinksService.deleteAll()
    }

    func save(menu: MenuModel) async throws {
        try await hamburgerService.add(items: menu.hamburgers ?? [])
        try await pastaService.add(items: menu.pasta ?? [])
        try await sandwichService.add(items: menu.sandwiches ?? [])
        try await drinksService.add(items: menu.drinks ?? [])
    }
    
    func replace(menu: MenuModel) async throws {
        try await clean()
        try await save(menu: menu)
    }
    
    func get() async throws -> MenuModel? {
        MenuModel(
            hamburgers: try await hamburgerService.getAll(),
            pasta: try await pastaService.getAll(),
            drinks: try await drinksService.getAll(),
            sandwiches: try await sandwichService.getAll()
        )
    }
}
