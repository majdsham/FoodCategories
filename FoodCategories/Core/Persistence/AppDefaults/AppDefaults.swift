//
//  AppDefaults.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//


extension Defaults {
    class AppDefaults {
        
        static var appLanguage: SupportedLanguage {
            set {
                Defaults.setString(newValue.rawValue, forKey: .appLanguage)
            }
            get {
                guard let lanSTring = Defaults.getString(forKey: .appLanguage),
                      let lan = SupportedLanguage(rawValue: lanSTring) else {
                    return .english
                }
                return lan
            }
        }
    }
}
