//
//  MenuViewModel.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import Foundation
import Combine
import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case rating = "Rating"
    case price = "Price"
    case vegan = "Vegan"
    case hot = "Hot"
    case availability = "Available"

    var id: String { rawValue }
}

enum SortOrder {
    case ascending
    case descending
}

@MainActor
final class MenuViewModel: ObservableObject {

    struct MenuItemWrapper: Identifiable {
        let menuItem: any MenuOptionProtocol
        var id: Int { menuItem.id }
    }

    @Published var items: [any MenuOptionProtocol]
    @Published var sortOption: SortOption = .rating
    @Published var sortOrder: SortOrder = .descending
    
    let category: MenuCategory

    init(category: MenuCategory, items: [any MenuOptionProtocol]) {
        self.category = category
        self.items = items
    }

    var sortedItems: [MenuItemWrapper] {
        items.sorted { item1, item2 in
            switch sortOption {
            case .rating:
                let rating1 = item1.rating ?? 0
                let rating2 = item2.rating ?? 0
                return sortOrder == .ascending ? rating1 < rating2 : rating1 > rating2
            case .price:
                let price1 = item1.price ?? 0
                let price2 = item2.price ?? 0
                return sortOrder == .ascending ? price1 < price2 : price1 > price2
            case .vegan:
                let vegan1 = item1.vegan ?? false
                let vegan2 = item2.vegan ?? false
                // true (vegan) comes first when ascending
                return sortOrder == .ascending ? (vegan1 == true && vegan2 == false) : (vegan1 == false && vegan2 == true)
            case .hot:
                let hot1 = item1.hot ?? false
                let hot2 = item2.hot ?? false
                 // true (hot) comes first when ascending
                return sortOrder == .ascending ? (hot1 == true && hot2 == false) : (hot1 == false && hot2 == true)
            case .availability:
                let available1 = item1.available ?? false
                let available2 = item2.available ?? false
                 // true (available) comes first when ascending
                return sortOrder == .ascending ? (available1 == true && available2 == false) : (available1 == false && available2 == true)
            }
        }
        .map(MenuItemWrapper.init)
    }
}
