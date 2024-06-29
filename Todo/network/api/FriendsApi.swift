import Foundation
import Alamofire

class FriendsNetworkManager {
    static let FriendsApi = FriendsNetworkManager()
    private init() {}
    
    // MARK: - GET
    
    // 내 친구 목록 조회
    func getMyFriends(completion: @escaping(Result<[Friends], Error>) -> Void) {
        
        let urlString = "http://\(Config().host)/friends"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders()).responseDecodable(of: [Friends].self){ response in
            switch response.result {
            case .success(let friends):
                completion(.success(friends))
                dump("my friends get success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("my friends get fail")
                dump(urlString)
            }
        }
    }
    
    // 받은 친구 요청 조회
    func getFriendRequests(completion: @escaping(Result<[FriendsRequest], Error>) -> Void) {
        let urlString = "http://\(Config().host)/friends/requests"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders()).responseDecodable(of: [FriendsRequest].self){ response in
            switch response.result {
            case .success(let friendsRequest):
                completion(.success(friendsRequest))
                dump("my friend requests get success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("my friend requests get fail")
                dump(urlString)
            }
        }
    }
    
    // 유저 검색
    func searchUser(nickname: String, completion: @escaping(Result<[Friends], Error>) -> Void) {
        let urlString = "http://\(Config().host)/friends/search?nickname=\(nickname)"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders()).responseDecodable(of: [Friends].self){ response in
            switch response.result {
            case .success(let friends):
                completion(.success(friends))
                dump("search user success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("search user fail")
                dump(urlString)
            }
        }
    }
    
    // MARK: - DELETE
    
    // 친구 요청 수락 여부
    func acceptFriendRequest(requestId: Int, status: Bool, completion: @escaping(Result<String, Error>) -> Void) {
        let urlString = "http://\(Config().host)/friends/requests/\(requestId)?status=\(status)"
        
        AF.request(urlString, method: .delete, headers: Config().getHeaders()).responseString{ response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
                dump("accept friend request success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("accept friend request fail")
                dump(urlString)
            }
        }
    }
    
    // 친구 삭제
    func deleteFriend(friendId: Int, completion: @escaping(Result<String, Error>) -> Void) {
        let urlString = "http://\(Config().host)/friends/\(friendId)"
        
        AF.request(urlString, method: .delete, headers: Config().getHeaders()).responseString{ response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
                dump("delete friend success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("delete friend fail")
                dump(urlString)
            }
        }
    }
}
