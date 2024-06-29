//
//  UserApi.swift
//  Todo
//
//  Created by 안홍범 on 6/22/24.
//

import Alamofire
import Foundation

// MARK: - UserSignupModel
struct UserSignup: Codable{
    // 회원가입 이메일, 비밀번호, 비밀번호 확인, 닉네임, 공개여부 설정
    let email : String
    let password :String
    let passwordCheck: String
    let nickname:String
    let userPublicScope: Bool
}

// MARK: - UserSignupApi
class UserSignupNetworkManager{
    
    static let UserSignupApi = UserSignupNetworkManager()
    private init() {}
    let host = "34.69.5.209:30008" // 추후 수정(GCP)
    
    // MARK: - POST
    func postSignup(UserSignup: UserSignup, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://" + Config().host + "users/signup"
        
        AF.request(urlString, method: .post, parameters: UserSignup, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response {response in
                switch response.result {
                case .success:
                    // 상태 코드가 200-299 범위에 있는 경우 성공 처리
                    completion(.success(()))
                    print("회원가입 성공")
                case .failure(let error):
                    // 실패 시 상태 코드와 응답 본문을 확인
                    if let statusCode = response.response?.statusCode {
                        print("회원가입 실패 with status code: \(statusCode)")
                    } else {
                        print("회원가입 실패 without status code")
                    }
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    completion(.failure(error))
                }
            }
    }
}
