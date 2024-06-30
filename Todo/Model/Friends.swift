//
//  Friends.swift
//  Todo
//
//  Created by 안홍범 on 6/28/24.
//

import Foundation
import Alamofire

// MARK: - FriendsModel
struct FriendsRequest: Codable{
    let requestId: Int
    let requestSenderId: Int
    let userNickname: String
    let requestCreatedAt: [Int]?
}

struct Friends: Codable{
    let userId: Int
    let userNickname: String
    let userImage: String?
}

struct FriendsTodo: Codable{
    let todoId: Int
    let categoryId: Int
    let todoTitle: String
    let todoDate: String
    let todoDone: Bool
}

struct FriendsTodoResponse: Decodable {
    let todos: [FriendsTodo]
}

struct FriendsTodoDetail: Codable{
    let categoryId: Int
    let todoTitle: String
    let todoContent: String
    let todoDate: String
    let todoDone: Bool
}
