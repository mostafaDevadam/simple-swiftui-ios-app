//
//  Models.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import Foundation

// user
struct User: Decodable, Identifiable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: Address
    var company: Company
    
    
}

// user-address
struct Address: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
}
// user-company
struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}

// post
struct Post: Decodable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
}

// comment
struct Comment: Decodable, Identifiable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

// todo
struct Todo {}

// photo
struct Photo {}
