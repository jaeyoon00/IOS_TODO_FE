import Foundation
import Alamofire
import Combine

class AuthService {
    static func signup(email: String, password: String, passwordCheck: String, nickname: String, userPublicScope: Bool) -> AnyPublisher<Bool, Error> {
        let url = "http://34.121.86.244:80/users/signup"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "passwordCheck": passwordCheck,
            "nickname": nickname,
            "userPublicScope": userPublicScope
        ]
        
        return Future { promise in
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { response in
                    if let httpResponse = response.response { //**
                        if (200..<300).contains(httpResponse.statusCode) { //**
                            // 응답이 성공 범위 내에 있는 경우
                            if let data = response.data {
                                if let jsonString = String(data: data, encoding: .utf8) { //**
                                    print("Success response JSON: \(jsonString)") //**
                                    // 응답이 단순 문자열일 경우 성공 처리
                                    if jsonString == "회원가입 성공" {
                                        promise(.success(true))
                                        return
                                    }
                                }
                                do {
                                    let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                                    print("Success response data: \(signUpResponse)")
                                    promise(.success(signUpResponse.success))
                                } catch {
                                    let errorMessage = "회원가입에 실패했습니다 정보를 확인해주세요"
                                    print(errorMessage)
                                    promise(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                }
                            }
                        } else {
                            // 응답이 성공 범위 밖에 있는 경우
                            if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                                print("Failure response data: \(errorResponse)")
                            }
                            let error = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "상태 코드: \(httpResponse.statusCode)로 요청 실패입니다"])
                            promise(.failure(error))
                        }
                    } else {
                        // 응답이 없는 경우
                        let error = NSError(domain: NSURLErrorDomain, code: URLError.unknown.rawValue, userInfo: [NSLocalizedDescriptionKey: "서버로부터 응답이 없습니다."])
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    
    // 로그인 기능 추가
    static func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> { //**
        let url = "http://34.121.86.244:80/users/login"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return Future { promise in
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { response in
                    if let httpResponse = response.response {
                        if (200..<300).contains(httpResponse.statusCode) {
                            // 응답이 성공 범위 내에 있는 경우
                            if let data = response.data {
                                if String(data: data, encoding: .utf8) != nil {
                                    print("로그인에 성공했습니다!")
                                }
                                do {
                                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data) //**
                                    UserDefaults.standard.set(loginResponse.token, forKey: "token")
                                    print("Success response data: \(loginResponse)")
                                    promise(.success(loginResponse)) //**
                                } catch {
                                    let errorMessage = "로그인에 실패했습니다 email과 Password를 확인해주세요"
                                    print(errorMessage)
                                    promise(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                                }
                            }
                        } else {
                            // 응답이 성공 범위 밖에 있는 경우
                            if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                                print("로그인 실패! 다시 정보를 확인해주세요")
                            }
                            let error = NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "email과 password를 확인해주세요"])
                            promise(.failure(error))
                        }
                    } else {
                        // 응답이 없는 경우
                        let error = NSError(domain: NSURLErrorDomain, code: URLError.unknown.rawValue, userInfo: [NSLocalizedDescriptionKey: "서버로부터 응답이 없습니다."])
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
