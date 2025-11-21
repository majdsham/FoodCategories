//
//  MainTabsLocalizationValues.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//



extension LocalizationManager {
    func mainTabsArabicValue(for key: MainTabsLocalizationKeys) -> String {
        switch key {
        case .home:
            return "الرئيسية"
        }
    }
    
    func mainTabsEnglishValue(for key: MainTabsLocalizationKeys) -> String {
        switch key {
        case .home:
            return "Home"
        }
    }
}
