//
//  UsersViewModel.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import Foundation
import Combine

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() {
        guard let url = URL(string : "https://jsonplaceholder.typicode.com/users")
        else { return }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil else { return }
            
            let users = try? JSONDecoder().decode([User].self, from: data)
            
            DispatchQueue.main.async {
                self.users = users ?? []
                //print("users#:",self.users)
            }
        }.resume()
    }
}
