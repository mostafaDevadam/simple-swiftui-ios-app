//
//  UsersView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users){ user in
                NavigationLink(destination: ProfileView(id: user.id)){
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(user.phone)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.email)
                            .font(.body)
                            .foregroundColor(.secondary)
                        /*Text(user.address.city)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Text(user.company.name)
                            .font(.body)
                            .foregroundColor(.secondary)*/
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.vertical, 4)
                    .listRowSeparator(.hidden)
                }
                
                
            }
            .listStyle(.plain)
            .onAppear{
                viewModel.fetchUsers()
                //print(viewModel.users)
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
