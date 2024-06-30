//  MyTodoModel.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Foundation

struct MyTodo: Codable {
    let todoId: Int
    let categoryId: Int
    let todoTitle: String
    let todoDate: String
    let todoDone: Bool
}

struct MyTodoResponse: Codable {
    let todos: [MyTodo]
}

struct MyTodoDetail: Codable {
    let categoryId: Int
    let todoTitle: String
    let todoContent: String
    let todoDate: String
    let todoDone: Bool
}

struct MyTodoUpdate: Codable {
    let todoId: Int
    let categoryId: Int
    let todoTitle: String
    let todoContent: String
    let todoDate: String
    let todoDone: Bool
}

struct MyTodoPost: Codable {
    let categoryId: Int
    let todoTitle: String
    let todoContent: String
    let todoDate: String
}
