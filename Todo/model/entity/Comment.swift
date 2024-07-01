//
//  Comment.swift
//  Todo
//
//  Created by 안홍범 on 6/26/24.
//

import Foundation
import Alamofire

// MARK: - CommentModel
struct Comment: Codable, Hashable{
    let id: Int
    let todoId: Int
    let userId: Int
    let nickname: String
    let image: String?
    let content: String
    let createdAt: [Int]
    let updatedAt: [Int]
}
