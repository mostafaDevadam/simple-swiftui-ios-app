//
//  _2_appApp.swift
//  12-app
//
//  Created by mostafa on 16/06/2026.
//

import SwiftUI

@main
struct _2_appApp: App {
    
    @StateObject private var languageManager = LanguageManager()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Inject the locale state down to ALL views in your app
           .environment(\.locale, languageManager.currentLocale)
           // Pass the manager instance so subviews can modify it
           .environmentObject(languageManager)
        }
    }
}
