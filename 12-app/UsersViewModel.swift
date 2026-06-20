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
    @Published var user: User? = nil
    
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
    
    
    func fetchUser(id: Int) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")
        else { return }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil else { return }
            
            let user = try? JSONDecoder().decode(User.self, from: data)
            
            
            DispatchQueue.main.async {
                self.user = user
            }
        }.resume()
    }
}
