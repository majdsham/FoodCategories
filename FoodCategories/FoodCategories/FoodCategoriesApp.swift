//
//  FoodCategoriesApp.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI
import CoreData

@main
struct FoodCategoriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
