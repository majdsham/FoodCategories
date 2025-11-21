//
//  MenuItemRowView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI

struct MenuItemRowView: View {
    let item: any MenuOptionProtocol

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let imageName = item.image, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.name ?? "Unknown Item")
                        .font(.headline)
                    Spacer()
                    Text(item.price ?? 0, format: .currency(code: "USD"))
                        .font(.subheadline)
                        .fontWeight(.medium)
                }

                if let description = item.description, !description.isEmpty {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                HStack {
                    if let rating = item.rating {
                        RatingView(rating: rating)
                    }
                    Spacer()
                    if !(item.available ?? true) {
                        Text("Unavailable")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                }
                
                tags
            }
        }
        .padding(.vertical, 8)
    }
    
    private var tags: some View {
        HStack {
            if item.vegan ?? false {
                Text("VEGAN")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.green)
                    .cornerRadius(6)
            }
            if item.hot ?? false {
                Text("HOT")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.orange.opacity(0.2))
                    .foregroundColor(.orange)
                    .cornerRadius(6)
            }
        }
    }
}
