//
//  MainTabsLocalizationKeys.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

enum MainTabsLocalizationKeys: String, LocalizationManager.LocalizationKey {
    case home
}

extension LocalizationManager.LocalizationKey {
    static func mainTabsHomeKey() -> MainTabsLocalizationKeys
    {
        .home
    }
}


