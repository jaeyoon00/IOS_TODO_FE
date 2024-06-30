import Foundation
import Alamofire

class FriendsTodoNetworkManager {
    static let FriendsTodoApi = FriendsTodoNetworkManager()
    private init() {}
    
    // MARK: - GET
    
    // 내 친구 Todo 조회
    // /todos/friends/{userId}?query={formattedDate}
    
    func getMyFriendsTodo(for userId: Int, date: DateComponents, completion: @escaping (Result<FriendsTodoResponse, Error>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: Calendar.current.date(from: date)!)
        
        let urlString = "http://\(Config().host)/todos/friends/\(userId)?query=\(formattedDate)"
        
        AF.request(urlString, method: .get, headers: Config().getHeaders()).responseDecodable(of: FriendsTodoResponse.self) { response in
            switch response.result {
            case .success(let friendsTodoResponse):
                completion(.success(friendsTodoResponse))
                dump("my friends todo get success")
                dump(urlString)
            case .failure(let error):
                completion(.failure(error))
                dump("my friends todo get fail")
                dump(urlString)
            }
        }
    }
}
