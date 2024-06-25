//
//  MyTodoApi.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Alamofire
import Foundation

// MARK: - MyTodoModel
struct MyTodo: Codable{
    // 유저 아이디, todo아이디, 카테고리 아이디, 제목, 상세 내용 , 날짜, 완료 여부
    let todoId: Int
    let categoryId: Int
    let todoTitle: String
    let todoDate: String
    let todoDone: Bool
}

struct MyTodoResponse: Codable {
    let todos: [MyTodo]
}

// MARK: - MyTodoApi
class MyTodoNetworkManager{
    
    static let MyTodoApi = MyTodoNetworkManager()
    private init() {}
    let host = "34.121.86.244:80" // 추후 수정(GCP)
        
    // MARK: - GET
    
    // 나의 할 일 목록 조회(쿼리 : 날짜별로 할 일 목록을 받아와야 함)
    func getMyTodoList(for date: DateComponents, completion: @escaping (Result<[MyTodo], Error>) -> Void) {
        
        guard let year = date.year, let month = date.month, let day = date.day else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid date components"])))
            return
        }
        
        let formattedDate = String(format: "%04d-%02d-%02d", year, month, day)
        let urlString = "http://\(host)/todos/me?query=\(formattedDate)"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: MyTodoResponse.self) { response in
                switch response.result {
                case .success(let myTodoList):
                    completion(.success(myTodoList.todos))
                    print("success")
                    print(urlString)
                case .failure(let error):
                    completion(.failure(error))
                    print(urlString)
                }
        }
        
        // 나의 할 일 상세 조회(todoId, categoryId, title, content, date, todoDone)
        func getTodoDetail(todoId: Int, completion: @escaping (Result<MyTodo, Error>) -> Void) {
            
            let urlString = "http://" + host + "/todos/" + String(todoId)
            
            AF.request(urlString)
                .validate()
                .responseDecodable(of: MyTodo.self) { response in
                    switch response.result {
                    case .success(let myTodo):
                        completion(.success(myTodo))
                        print("success")
                        print(urlString)
                    case .failure(let error):
                        completion(.failure(error))
                        print(urlString)
                    }
                }
        }
        
        // MARK: - POST
        
        // 나의 할 일 추가
        func postMyTodo(myTodo: MyTodo, completion: @escaping (Result<MyTodo, Error>) -> Void) {
            
            let urlString = "http://" + host + "/todos/"
            let postParameters : [String: Any] = [
                "categoryId": myTodo.categoryId,
                "title": myTodo.todoTitle,
                "date": myTodo.todoDate,
                "todoDone": myTodo.todoDone
            ]
            
            AF.request(urlString, method: .post, parameters: myTodo , encoder: JSONParameterEncoder.default)
                .validate()
                .responseDecodable(of: MyTodo.self) { response in
                    switch response.result {
                    case .success(let myTodo):
                        completion(.success(myTodo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        
        // MARK: - PUT
        
        // 나의 할 일 수정
        func putMyTodo(myTodo: MyTodo, completion: @escaping (Result<MyTodo, Error>) -> Void) {
            
            let urlString = "http://" + host + "/todos/" + String(myTodo.todoId)
            
            AF.request(urlString, method: .put, parameters: myTodo, encoder: JSONParameterEncoder.default)
                .validate()
                .responseDecodable(of: MyTodo.self) { response in
                    switch response.result {
                    case .success(let myTodo):
                        completion(.success(myTodo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        
        // MARK: - DELETE
        
        // 나의 할 일 삭제
        func deleteMyTodo(todoId: Int, completion: @escaping (Result<MyTodo, Error>) -> Void) {
            
            let urlString = "http://" + host + "/todos/" + String(todoId)
            
            AF.request(urlString, method: .delete)
                .validate()
                .responseDecodable(of: MyTodo.self) { response in
                    switch response.result {
                    case .success(let myTodo):
                        completion(.success(myTodo))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        
    }
}
