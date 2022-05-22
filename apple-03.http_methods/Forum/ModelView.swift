//
//  Post.swift
//  Forum
//
//  Created by Emmanuel Solis on 3/3/22.
//

import Foundation

final class ModelView {
  var my_post = Post()
  
  func get_server_info() -> Void {
    // Basic needed to make the request.
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
    let url_session = URLSession.shared
    
    // Request to the server.
    url_session.dataTask(with: url) { data, header, error in
      if let data = data {
        let decoder = JSONDecoder()
        let new_post = try! decoder.decode(Post.self, from:data)
        print("User ID: \(Int(new_post.userID))")
        print("Post ID: \(Int(new_post.id))")
        print("Title: \(String(describing: new_post.title))")
        print("Body: \(String(describing: new_post.body))")
      }
    }.resume()
  }
}
