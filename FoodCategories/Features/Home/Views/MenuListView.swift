//
//  MenuListView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI

struct MenuListView: View {
    @StateObject private var viewModel: MenuViewModel

    init(category: MenuCategory, items: [any MenuOptionProtocol]) {
        _viewModel = StateObject(wrappedValue: MenuViewModel(category: category, items: items))
    }

    var body: some View {
        List(viewModel.sortedItems) { itemWrapper in
            MenuItemRowView(item: itemWrapper.menuItem)
        }
        .navigationTitle(viewModel.category.rawValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                sortingMenu
            }
        }
    }

    private var sortingMenu: some View {
        Menu {
            Picker("Sort by", selection: $viewModel.sortOption) {
                ForEach(SortOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }

            if viewModel.sortOption == .price {
                Picker("Order", selection: $viewModel.sortOrder) {
                    Text("Ascending").tag(SortOrder.ascending)
                    Text("Descending").tag(SortOrder.descending)
                }
            }

        } label: {
            Image(systemName: "arrow.up.arrow.down.circle")
        }
    }
}
