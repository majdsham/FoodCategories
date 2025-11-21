//
//  RatingView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    private let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: starType(for: index))
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
        }
    }

    private func starType(for index: Int) -> String {
        let ratingValue = rating
        if ratingValue >= Double(index) + 1 {
            return "star.fill"
        } else if ratingValue >= Double(index) + 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
