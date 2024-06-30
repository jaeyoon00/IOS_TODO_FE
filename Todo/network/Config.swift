import Foundation
import Alamofire

class Config {
    let host = "34.121.86.244:80"
    var token: String?{
        return UserDefaults.standard.string(forKey: "token")
    }
    
    let testToken : HTTPHeaders = [ "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUiLCJlbWFpbCI6InRlc3RAbmF2ZXIuY29tIiwibmlja05hbWUiOiLslYjtmY3rspQifQ.HKzu8MSkgwiq2R5zaaK5a-i14pObFS8SqCulwMjx618",
        "Accept": "application/json"
    ]
    
    func getHeaders() -> HTTPHeaders {
        return [
            "Authorization": "Bearer \(token ?? "")",
            "Accept": "application/json"
        ]
    }
}
