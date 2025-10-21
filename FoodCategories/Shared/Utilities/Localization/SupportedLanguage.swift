//
//  SupportedLanguage.swift
//  TestOf2P
//
//  Created by Majd Aldeyn Ez Alrejal on 30/08/2025.
//

import UIKit


enum SupportedLanguage: String {
    
    case arabic = "ar"
    case english = "en"
    
    var local: Locale {
        return Locale(identifier: self.rawValue)
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .arabic:
            return .right
        case .english:
            return .left
        }
    }
    
    static func changeLanguage(LanguageShared : String){
        
        if LanguageShared.elementsEqual("ar")
        {
            Defaults.AppDefaults.appLanguage = .arabic
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
}

