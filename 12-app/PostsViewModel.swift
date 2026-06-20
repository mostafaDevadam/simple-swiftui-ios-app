//
//  PostsViewModel.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import Foundation
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var post: Post? = nil
    /*@Published var post: Post = Post(userId: 0, id: 0, title: "", body: "")*/
    
    func fetchPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
                 else { return }
          
        URLSession.shared.dataTask(with: url) {
            data, response , error in
            
            guard let data = data, error == nil else {return}
            
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async {
                self.posts = posts ?? []
            }
            
        }.resume()
            
                
                
    }
    
    func fetchPostById(id: Int) {
        
        print("fetchPostById id:", id)
        
        //
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url){
            data, response, error in
            
            guard let data = data, error == nil else { return }
            
            let post = try? JSONDecoder().decode(Post.self, from: data)
            
            DispatchQueue.main.async {
                self.post = post
            }
            
            
            
            
            
        }.resume()
    }
    
}


