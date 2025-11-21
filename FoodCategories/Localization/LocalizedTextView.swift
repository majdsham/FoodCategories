//
//  LocalizedTextView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

import SwiftUI

struct LocalizedTextView: View {
    
    var key: any LocalizationManager.LocalizationKey
    @AppStorage(.currentAppLanguageStorageKey) private var currentLanguage: LanguagesEnum?
    
    var body: some View {
        if currentLanguage == .en {
            Text(LocalizationManager.shared.enValue(for: key))
        } else {
            Text(LocalizationManager.shared.arValue(for: key))
        }
    }
}
