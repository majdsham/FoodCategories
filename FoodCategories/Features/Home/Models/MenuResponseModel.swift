//
//  MenuResponseModel.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//

struct MenuResponseModel: Codable {
    let menu: MenuModel?
}

struct RecordResponseModel: Codable {
    let record: MenuResponseModel?
}
