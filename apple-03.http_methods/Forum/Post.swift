//
//  Post.swift
//  Forum
//
//  Created by Emmanuel Solis on 3/3/22.
//

import Foundation

import Foundation

struct Post: Codable {
  let userID: Int
  let id: Int
  let title: String
  let body: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case id, title, body
  }
  
  init() {
    userID = -1
    id = -1
    title = ""
    body = ""
  }
}

