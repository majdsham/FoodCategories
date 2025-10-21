//
//  RatingStarView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 31/08/2025.
//

import SwiftUI

struct RatingStarView: View {
    let rating: Double
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 12))
            
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
