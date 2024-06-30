//
//  LoginResponse.swift
//  Todo
//
//  Created by 김재윤 on 6/27/24.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let tokenType: String
}
