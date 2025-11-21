//
//  AppMainTabsEnum.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

import SwiftUI

enum AppMainTabsEnum: String, CaseIterable, Identifiable {
    case home
    case search
    case profile
    case explore
    
    var id: String { self.rawValue }
}

extension AppMainTabsEnum {
    @ViewBuilder
    var tabBarDestination: some View {
        switch self {
        case .home:
            HomeView()
        case .search:
            Image(systemName: "magnifyingglass")
        case .profile:
            Image(systemName: "person")
        case .explore:
            Image(systemName: "square.and.arrow.up")
        }
    }
}
