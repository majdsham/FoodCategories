//
//  LocalizationManager.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

import SwiftUI

class LocalizationManager {
    static var shared = LocalizationManager()
    
    @AppStorage(.currentAppLanguageStorageKey) var currentLanguage: LanguagesEnum = .en
    
    func arValue(for key: any LocalizationKey) -> String {
        switch key.self {
            case is MainTabsLocalizationKeys:
            return mainTabsArabicValue(for: key as! MainTabsLocalizationKeys)
        default:
            return ""
        }
    }
    
    func enValue(for key: any LocalizationKey) -> String {
        switch key.self {
            case is MainTabsLocalizationKeys:
            return mainTabsEnglishValue(for: key as! MainTabsLocalizationKeys)
        default:
            return ""
        }
    }
}
