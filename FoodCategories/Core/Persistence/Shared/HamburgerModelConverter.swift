//
//  HamburgerModelConverter.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 18/09/2025.
//

protocol EntityToModelConverter {
    associatedtype T: AppModel
    func convert() -> T
}
