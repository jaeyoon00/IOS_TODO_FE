class FriendsManager {
    static let shared = FriendsManager()
    
    private init() {}
    
    var friends: [String] = []
    var friendRequestsNickname: [String] = []
    var friendRequestsCreatedAt: [[Int]] = []
    var friendRequestsIds: [Int] = [] // requestId 저장
    
    func addFriend(_ friend: String) {
        friends.append(friend)
    }
    
    func removeFriend(_ friend: String) {
        friends.removeAll { $0 == friend }
    }
    
    func getAllFriends(completion: @escaping ([String]) -> Void) {
        FriendsNetworkManager.FriendsApi.getMyFriends { result in
            switch result {
            case .success(let myfriends):
                self.friends = myfriends.map { $0.userNickname }
                completion(self.friends)
            case .failure(let error):
                print(error)
                completion(self.friends) // or handle the error appropriately
            }
        }
    }
    
    // 친구요청(닉네임, 요청시간) 조회
    func getFriendRequests(completion: @escaping ([String], [[Int]], [Int]) -> Void) {
        FriendsNetworkManager.FriendsApi.getFriendRequests { result in
            switch result {
            case .success(let friendRequests):
                self.friendRequestsNickname = friendRequests.map { $0.userNickname }
                self.friendRequestsCreatedAt = friendRequests.map { $0.requestCreatedAt ?? [] }
                self.friendRequestsIds = friendRequests.map { $0.requestId }
                completion(self.friendRequestsNickname, self.friendRequestsCreatedAt, self.friendRequestsIds)
            case .failure(let error):
                print(error)
                completion(self.friendRequestsNickname, self.friendRequestsCreatedAt, self.friendRequestsIds) // or handle the error appropriately
            }
        }
    }
    
    // 친구요청 수락 or 거절 (status가 true면 수락, false면 거절)
    func acceptFriendRequest(requestId: Int, status: Bool, completion: @escaping (String) -> Void) {
        FriendsNetworkManager.FriendsApi.acceptFriendRequest(requestId: requestId, status: status) { result in
            switch result {
            case .success(let message):
                completion(message)
            case .failure(let error):
                print(error)
                completion("친구요청 수락/거절 실패")
            }
        }
    }
}
