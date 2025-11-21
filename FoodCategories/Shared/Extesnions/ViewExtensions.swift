//
//  ViewExtensions.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/4/25.
//

import SwiftUI

extension View {
    func generateShadow() -> some View {
        shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}
