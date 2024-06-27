//
//  UserInfoResponse.swift
//  Todo
//
//  Created by 김재윤 on 6/27/24.
//

import Foundation

struct UserInfoResponse: Decodable {
    let nickname: String
    let email: String
    let userPublicScope: Bool
}
