//
//  PostsView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel()
    
    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading){
                Text(post.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(post.body)
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
        }
        .listStyle(.plain)
        .onAppear{
            viewModel.fetchPosts()
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
