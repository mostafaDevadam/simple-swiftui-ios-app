//
//  SettingsView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 30) {
                   
                    
                    /*HStack(spacing: 20) {
                        // Button 1: Switch to English
                        Button(action: {
                            languageManager.changeLanguage(to: "en")
                        }) {
                            Text("English")
                                .padding()
                                .background(languageManager.currentLocale.identifier == "en" ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        // Button 2: Switch to German
                        Button(action: {
                            languageManager.changeLanguage(to: "de")
                        }) {
                            Text("Deutsch")
                                .padding()
                                .background(languageManager.currentLocale.identifier == "de" ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }*/
            
            Form {
                        // Sektion für die App-Einstellungen
                        Section(header: Text("App Settings")) {
                            
                            // 2. Ein Picker-Menü für die Sprachauswahl
                            Picker("Language / Sprache", selection: Binding(
                                get: { languageManager.currentLocale.identifier },
                                set: { languageManager.changeLanguage(to: $0) }
                            )) {
                                Text("English").tag("en")
                                Text("Deutsch").tag("de")
                                Text("Arabic").tag("ar")
                            }
                            .pickerStyle(SegmentedPickerStyle()) // Zeigt nebeneinander liegende Buttons an
                            // Alternativ für ein Aufklapp-Menü: .pickerStyle(MenuPickerStyle())
                            
                        }
                        
                        // Beispiel für eine weitere Sektion mit lokalisiertem Text
                        Section {
                            HStack {
                                Text("Current Status:")
                                Spacer()
                                Text("welcome_message") // Test-String aus deiner Localizable.strings
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .navigationTitle("Settings")
                
            
            
                }
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                                        Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.body)
                            .bold()
                        Text("back")
                            .font(.body)
                            .bold()
                    }
                }
                )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
