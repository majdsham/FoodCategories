//
//  AppEnvironment.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 29/08/2025.
//

enum AppEnvironment {
    case stage
    case dev
    case live
    
    var baseURL: String {
        switch self {
        case .dev:
            return "https://api.jsonbin.io"
        case .stage:
            return "https://api.jsonbin.io"
        case .live:
            return "https://api.jsonbin.io"
        }
    }
}
