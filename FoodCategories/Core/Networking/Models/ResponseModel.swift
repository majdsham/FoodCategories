//
//  ResponseModel.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//


struct APIResponse<T: Codable>: Codable {
    let message: String?
    let data: T?
}
