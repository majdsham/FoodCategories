//
//  ErrorResponse.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//


struct ErrorResponse: Encodable, Error {

    let message: String
    let code: Int
    init(message: String, code: Int = 0) {
        self.message = message
        self.code = code
    }
    
}
