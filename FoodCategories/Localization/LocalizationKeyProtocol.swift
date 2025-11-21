//
//  LocalizationKeyProtocol.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//


extension LocalizationManager {
    protocol LocalizationKey {
        func keyString() -> String
    }
}

extension LocalizationManager.LocalizationKey {
    func keyString() -> String {
        String(describing: self)
    }
}
