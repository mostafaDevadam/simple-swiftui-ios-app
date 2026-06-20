//
//  LanguageManager.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import Foundation

import SwiftUI

class LanguageManager: ObservableObject {
    // 1. Get saved language or default to device language
    @Published var currentLocale: Locale = {
        let savedLanguage = UserDefaults.standard.string(forKey: "selected_language") ?? "en"
        return Locale(identifier: savedLanguage)
    }()
    
    func changeLanguage(to languageCode: String) {
        // 2. Save choice to disk
        UserDefaults.standard.set(languageCode, forKey: "selected_language")
        
        // 3. Update published value to trigger UI reload
        withAnimation {
            self.currentLocale = Locale(identifier: languageCode)
        }
    }
}
