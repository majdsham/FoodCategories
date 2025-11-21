//
//  NavigationManager.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

import SwiftUI
import Combine

@MainActor
class NavigationManager: ObservableObject {
    static let shared: NavigationManager = NavigationManager()
    @Published var homeRouter: AppRouter = AppRouter()
    @Published var tabViewNavigation: AppRouter = AppRouter()
}
