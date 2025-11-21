//
//  HomeService.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//


import Combine

protocol HomeServicing {
    func fetchMenu() -> AnyPublisher<RecordResponseModel?, ErrorResponse>
    func fetchMenuAsync() async throws -> RecordResponseModel?
}

final class HomeService: HomeServicing {
    func fetchMenu() -> AnyPublisher<RecordResponseModel?, ErrorResponse> {
        return CombineApiClient.shared
            .request(RecordResponseModel?.self,
                     endPoint: .init(path: EndPoints.Data.All))
            .map(\.self)
            .eraseToAnyPublisher()
    }
    
    func fetchMenuAsync() async throws -> RecordResponseModel? {
        return try await AsynAwaitApiClient.shared.request(RecordResponseModel?.self, endPoint: .init(path: EndPoints.Data.All))
    }
}

/*
 
 // 1. Define the protocol with the public interface for the Home View.
 protocol HomeVMProtocol: ObservableObject {
     var menu: MenuModel? { get }
     var state: AppViewModel.State { get }
     
     func fetchMenu() async
     func menuOptionAccodingCategory(category: MenuCategory) -> [any MenuOptionProtocol]
 }

 // 2. Create a mock implementation for SwiftUI Previews and testing.
 @MainActor
 final class MockHomeVM: AppViewModel, HomeVMProtocol {
     @Published var menu: MenuModel?
     
     override init() {
         super.init()
         self.menu = createMockMenu()
         self.state = .loaded
         self.isConnected = true
     }
     
     func fetchMenu() async {
         // The mock VM has its data immediately, so this does nothing.
     }
     
     func menuOptionAccodingCategory(category: MenuCategory) -> [any MenuOptionProtocol] {
         switch category {
         case .drinks:
             return menu?.drinks ?? []
         case .pasta:
             return menu?.pasta ?? []
         case .hamburgers:
             return menu?.hamburgers ?? []
         case .sandwiches:
             return menu?.sandwiches ?? []
         }
     }
     
     private func createMockMenu() -> MenuModel {
         let hamburgers: [HamburgerModel] = [
             .init(id: 1, name: "Classic Burger", price: 9.99, description: "A timeless classic with lettuce, tomato, and our special sauce.", vegan: false, hot: false, rating: 4.5, image: "classic_burger", available: true),
             .init(id: 2, name: "Spicy Jalapeño Burger", price: 11.50, description: "For those who like it hot, with spicy jalapeños and pepper jack cheese.", vegan: false, hot: true, rating: 4.7, image: "jalapeno_burger", available: true),
             .init(id: 3, name: "Vegan Delight Burger", price: 12.99, description: "A delicious plant-based patty with fresh avocado and vegan cheese.", vegan: true, hot: false, rating: 4.8, image: "vegan_burger", available: false)
         ]
         
         let pasta: [PastaModel] = [
             .init(id: 4, name: "Spaghetti Carbonara", price: 14.00, description: "Creamy pasta with pancetta and a touch of black pepper.", vegan: false, hot: false, rating: 4.9, image: "carbonara", available: true),
             .init(id: 5, name: "Penne Arrabbiata", price: 12.50, description: "A spicy tomato sauce that will awaken your senses.", vegan: true, hot: true, rating: 4.6, image: "arrabbiata", available: true)
         ]
         
         let drinks: [DrinkModel] = [
             .init(id: 6, name: "Fresh Lemonade", price: 3.50, description: "Cool and refreshing, made with real lemons.", vegan: true, hot: false, rating: 4.8, image: "lemonade", available: true),
             .init(id: 7, name: "Iced Tea", price: 3.00, description: "Classic black iced tea.", vegan: true, hot: false, rating: 4.5, image: "iced_tea", available: true)
         ]
         
         let sandwiches: [SandwichModel] = [
             .init(id: 8, name: "Club Sandwich", price: 13.50, description: "Triple-decker with turkey, bacon, lettuce, and tomato.", vegan: false, hot: false, rating: 4.7, image: "club_sandwich", available: true),
             .init(id: 9, name: "Caprese Sandwich", price: 11.00, description: "Fresh mozzarella, tomatoes, and basil on ciabatta.", vegan: true, hot: false, rating: 4.6, image: "caprese_sandwich", available: true)
         ]
         
         return MenuModel(hamburgers: hamburgers, pasta: pasta, drinks: drinks, sandwiches: sandwiches)
     }
 }

 */
