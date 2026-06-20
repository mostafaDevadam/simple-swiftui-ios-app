//
//  ProfileView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var vm = UsersViewModel()
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("profile \(self.id)")
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("profile \(self.id)")
                .font(.title)
            
            
            if let user = vm.user {
                VStack{
                    //
                    VStack(alignment: .leading){
                        Text("Info")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack{
                            Text("Name:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.name)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("phone:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.phone)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("email:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.email)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("website:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text(user.website)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    //
                    VStack(alignment: .leading){
                        Text("Address")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(user.address.street)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.address.city)
                            .font(.body)
                            .foregroundColor(.primary)
                        Text(user.address.suite)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.address.zipcode)
                            .font(.body)
                            .foregroundColor(.secondary)
                       
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    //
                    //
                    VStack(alignment: .leading){
                        Text("Company")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(user.company.name)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.company.bs)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.company.catchPhrase)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                    
                    Spacer()
                }
            } else {
                ProgressView("Loading User...")
            }
            
            
            
            
        }
        .padding()
        .onAppear{
            vm.fetchUser(id: self.id)
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(id: 1)
    }
}
