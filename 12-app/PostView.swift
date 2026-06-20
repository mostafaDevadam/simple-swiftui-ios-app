//
//  PostView.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import SwiftUI

struct PostView: View {
    @StateObject private var post_vm = PostsViewModel()
    @StateObject private var comments_vm = CommentsViewModel()
    
    let postId: Int
    init(postId: Int) {
        self.postId = postId
        print("postdId:", postId)
    }
    var body: some View {
        VStack {
            if let p = post_vm.post{
                VStack(alignment: .leading){
                    Text(p.title)
                        .font(.headline)
                    Text(p.body)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1),radius: 5,x: 0, y: 2)
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
            } else {
                ProgressView("Loading post...")
            }
            Divider()
            //Text(" \(post_vm.post?.title)")
            Text("comments")
                .font(.title)
            
            List(comments_vm.comments){ com in
                
                VStack(alignment: .leading){
                    Text(com.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(com.body )
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1),radius: 5,x: 0, y: 2)
                .padding(.vertical, 4)
                .listRowSeparator(.hidden)
                
                
            }
            .listStyle(.plain)
            .onAppear{
                post_vm.fetchPostById(id: self.postId)
                comments_vm.fetchCommentsByPostId(postId: self.postId)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(postId: 1)
    }
}
