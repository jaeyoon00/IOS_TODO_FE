//
//  EditResponse.swift
//  Todo
//
//  Created by 김재윤 on 6/28/24.
//

import Foundation

struct UserInfoEditRequest: Codable {
    let nickname: String?
    let password: String?
    let image : String?
    let userPublicScope :Bool?
}
