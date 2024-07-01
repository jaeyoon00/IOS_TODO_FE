//
//  MyTodoApi.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Alamofire
import Foundation

// MARK: - MyTodoApi
class MyTodoNetworkManager{
    
    static let MyTodoApi = MyTodoNetworkManager()
    private init() {}
        
    // MARK: - GET
    
    // 나의 할 일 목록 조회(쿼리 : 날짜별로 할 일 목록을 받아와야 함)
    func getMyTodoList(for date: DateComponents, completion: @escaping (Result<[MyTodo], Error>) -> Void) {
        
        guard let year = date.year, let month = date.month, let day = date.day else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid date components"])))
            return
        }
        
        let formattedDate = String(format: "%04d-%02d-%02d", year, month, day)
        
        let urlString = "http://\(Config().host)/todos/me?query=\(formattedDate)"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders())
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
                    print(Config().getHeaders())
                }
            }
    }
        
    // 나의 할 일 상세 조회(todoId, categoryId, title, content, date, todoDone)
    func getTodoDetail(todoId: Int, completion: @escaping (Result<MyTodoDetail, Error>) -> Void) {
        
        let urlString = "http://" + Config().host + "/todos/" + String(todoId)
            
        AF.request(urlString, method: .get, headers: Config().getHeaders())
            .validate()
            .responseDecodable(of: MyTodoDetail.self) { response in
                switch response.result {
                case .success(let MyTodoDetail):
                completion(.success(MyTodoDetail))
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
    func postMyTodo(MyTodoPost: MyTodoPost, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://" + Config().host + "/todos/"

        AF.request(urlString, method: .post, parameters: MyTodoPost, encoder: JSONParameterEncoder.default, headers: Config().getHeaders())
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    // 상태 코드가 200-299 범위에 있는 경우 성공 처리
                    completion(.success(()))
                    print("등록 성공")
                case .failure(let error):
                    // 실패 시 상태 코드와 응답 본문을 확인
                    if let statusCode = response.response?.statusCode {
                        print("등록 실패 with status code: \(statusCode)")
                    } else {
                        print("등록 실패 without status code")
                    }

                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    completion(.failure(error))
                }
            }
    }

        
    // MARK: - PUT
        
    // 나의 할 일 수정
    func updateMyTodo(MyTodoUpdate: MyTodoUpdate, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let urlString = "http://" + Config().host + "/todos/" + String(MyTodoUpdate.todoId)
            
        AF.request(urlString, method: .put, parameters: MyTodoUpdate, encoder: JSONParameterEncoder.default, headers: Config().getHeaders())
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    // 상태 코드가 200-299 범위에 있는 경우 성공 처리
                    completion(.success(()))
                    print("등록 성공")
                case .failure(let error):
                    // 실패 시 상태 코드와 응답 본문을 확인
                    if let statusCode = response.response?.statusCode {
                        print("수정 실패 with status code: \(statusCode)")
                    } else {
                        print("수정 실패 without status code")
                    }
                    
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    completion(.failure(error))
                }
            }
    }
        
    // MARK: - DELETE
    
    // 나의 할 일 삭제
    func deleteMyTodo(todoId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let urlString = "http://" + Config().host + "/todos/" + String(todoId)

        AF.request(urlString, method: .delete, headers: Config().getHeaders())
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    // 상태 코드가 200-299 범위에 있는 경우 성공 처리
                    completion(.success(()))
                    print("delete success")
                    print(urlString)
                case .failure(let error):
                    // 실패 시 상태 코드와 응답 본문을 확인
                    if let statusCode = response.response?.statusCode {
                        print("delete failure with status code: \(statusCode)")
                    } else {
                        print("delete failure without status code")
                    }

                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }

                    completion(.failure(error))
                }
            }
    }
}

