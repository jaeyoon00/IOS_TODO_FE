//
//  SignUpResponse.swift
//  Todo
//
//  Created by 김재윤 on 6/27/24.
//

import Foundation

struct SignUpResponse: Decodable {
    let success: Bool
    let message: String?
}
