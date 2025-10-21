//
//  Defaults.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//

import Foundation
import SwiftUI

class Defaults {
    static private let defaults = UserDefaults.standard
    
    enum DefaultsKeys: String {
        case appLanguage = "APP_LANGUAGE_KEY"
    }
    
    
    static func setString(_ value: String?, forKey key: DefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func getString(forKey key: DefaultsKeys) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    static func setInt(_ value: Int?, forKey key: DefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func getInt(forKey key: DefaultsKeys) -> Int? {
        return defaults.integer(forKey: key.rawValue)
    }
    
    static func setBool(_ value: Bool?, forKey key: DefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    static func getBool(forKey key: DefaultsKeys) -> Bool? {
        return defaults.bool(forKey: key.rawValue)
    }
    
    static func getBool(forKey key: String) -> Bool? {
        return defaults.bool(forKey: key)
    }
    
    static func setBool(_ value: Bool?, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    static func setStringArray(_ array: [String]?, forKey key: DefaultsKeys) {
        defaults.set(array, forKey: key.rawValue)
    }

    static func getStringArray(forKey key: DefaultsKeys) -> [String]? {
        return defaults.stringArray(forKey: key.rawValue)
    }
    
}
