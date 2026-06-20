//
//  CommentsViewModel.swift
//  12-app
//
//  Created by mostafa on 20/06/2026.
//

import Foundation
import Combine


class CommentsViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    //func fetchComments(){}
    
    func fetchCommentsByPostId(postId: Int){
        
        print("fetchCommentsByPostId postid:", postId)
        
        //
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)")
        else { return }
        
        URLSession.shared.dataTask(with: url){
            data, response, error in
            
            guard let data = data, error == nil else { return }
            
            let comments = try? JSONDecoder().decode([Comment].self, from: data)
            
            DispatchQueue.main.async {
                self.comments = comments ?? []
            }
        }.resume()
    }
}
