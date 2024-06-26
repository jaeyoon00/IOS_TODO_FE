//
//  CommentApi.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Foundation
import Alamofire

class CommentNetworkManager{
    
    static let CommentApi = CommentNetworkManager()
    private init() {}
    
    // MARK: - GET
    func getCommentList(for todoId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        
        let urlString = "http://\(Config().host)/todos/\(todoId)/comments"
        
        AF.request(urlString, method: .get, headers: Config().headers).responseDecodable(of: [Comment].self) { response in
            switch response.result {
            case .success(let comments):
                completion(.success(comments))
                print("success")
                print(urlString)
            case .failure(let error):
                completion(.failure(error))
                print("fail")
                print(urlString)
            }
        }
        
    }
    
    // MARK: - POST
    func postComment(for todoId: Int, content: String, completion: @escaping (Result<Comment, Error>) -> Void) {
        
        let urlString = "http://\(Config().host)/todos/\(todoId)/comments"
        
        let parameters: [String: Any] = [
            "content": content
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Config().headers).responseDecodable(of: Comment.self) { response in
            switch response.result {
            case .success(let comment):
                completion(.success(comment))
                print("success")
                print(urlString)
            case .failure(let error):
                completion(.failure(error))
                print("fail")
                print(urlString)
            }
        }
        
    }
    
    // MARK: - UPDATE
    func updateComment(for todoId: Int, commentId: Int, content: String, completion: @escaping (Result<Comment, Error>) -> Void) {
        
        let urlString = "http://\(Config().host)/todos/\(todoId)/comments/\(commentId)"
        
        let parameters: [String: Any] = [
            "content": content
        ]
        
        AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: Config().headers).responseDecodable(of: Comment.self) { response in
            switch response.result {
            case .success(let comment):
                completion(.success(comment))
                print("success")
                print(urlString)
            case .failure(let error):
                completion(.failure(error))
                print("fail")
                print(urlString)
            }
        }
    }
    
    // MARK: - DELETE
    func deleteComment(for todoId: Int, commentId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let urlString = "http://\(Config().host)/todos/\(todoId)/comments/\(commentId)"
        
        AF.request(urlString, method: .delete, headers: Config().headers).response { response in
            switch response.result {
            case .success:
                completion(.success(()))
                print("success")
                print(urlString)
            case .failure(let error):
                completion(.failure(error))
                print("fail")
                print(urlString)
            }
        }
    }
}
