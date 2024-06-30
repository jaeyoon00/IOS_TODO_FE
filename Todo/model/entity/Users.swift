//
//  Users.swift
//  Todo
//
//  Created by 안홍범 on 6/29/24.
//

import Foundation

struct Users: Codable {
    let userId: Int
    let nickname: String
    let image: String?
    let userPublicScope: Bool
}
