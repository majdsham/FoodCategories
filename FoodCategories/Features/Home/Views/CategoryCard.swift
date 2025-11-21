//
//  CategoryCard.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/4/25.
//


import SwiftUI

struct CategoryCard: View {
    let category: MenuCategory
    let numberOfItemInCategory: Int
    @Environment(AppRouter.self) var router: AppRouter
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
                .overlay {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(category.rawValue)
                            .font(.system(.title, design: .serif).weight(.bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(numberOfItemInCategory) items")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.leading, 50)
                    .padding(.trailing, 30)
                }
                .cornerRadius(25)
                .frame(height: 120)
                .padding(.trailing, 20)
                .padding(.leading, 40)
                .generateShadow()
            
            HStack {
                
                AsyncImage(url: URL(string: "https://picsum.photos/200")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Circle().fill(.thinMaterial)
                        ProgressView()
                    }
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .generateShadow()
                
                Spacer()
                
                chevronView
                    .frame(width: 40)
                    .generateShadow()
                    .onTapGesture {
                        print("clicked")
                        router.push(HomeDestination.openDetails(category: category))
                        
                    }
            }
        }
    }
    
    var chevronView: some View {
        ZStack {
            Circle()
                .fill(.white)
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.accent)
        }
    }
}
