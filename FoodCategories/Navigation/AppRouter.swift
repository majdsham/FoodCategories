//
//  AppRouter.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/5/25.
//

import SwiftUI

// This Router holds the "path" for one navigation stack
@Observable
class AppRouter {
    // The NavigationPath holds the stack of views
    var path = NavigationPath()

    // A function to push any new view onto the stack
    func push<T: Hashable>(_ value: T) {
        path.append(value)
    }

    // A function to go back one level
    func pop() {
        path.removeLast()
    }

    // A function to go all the way back to the root
    func popToRoot() {
        path.removeLast(path.count)
    }
}
