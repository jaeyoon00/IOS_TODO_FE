//
//  FriendsManager.swift
//  Todo
//
//  Created by 김재윤 on 6/20/24.
//

import Foundation

class FriendsManager {
    static let shared = FriendsManager()
    
    private init() {}
    
    var friends = ["김정렬", "김재윤", "박미람", "김부자", "안홍범", "정희석"]
    
    func addFriend(_ friend: String) {
        friends.append(friend)
    }
    
    func removeFriend(_ friend: String) {
        friends.removeAll { $0 == friend }
    }
    
    func getAllFriends() -> [String] {
        return friends
    }
}
