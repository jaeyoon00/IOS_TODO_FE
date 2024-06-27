//
//  Config.swift
//  Todo
//
//  Created by 안홍범 on 6/26/24.
//

import Foundation
import Alamofire

class Config{
    let host = "34.121.86.244:80"
    
    // 임시 토큰
    let headers: HTTPHeaders = [
        "Authorization": "Bearer " + "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtaXJhbUBuYXZlci5jb20iLCJlbWFpbCI6Im1pcmFtQG5hdmVyLmNvbSIsImlkIjoxLCJuaWNrbmFtZSI6IuuvnOuiiCIsImV4cCI6NzcxOTI5NTg2OX0.YBRJwiZHx4KoQ7NqJVKJLLMMXlc6MXcGBCwVDj8Z-YNshlTTSKbNxXm_Lpf05q4v",
        "Accept": "application/json"
    ]
}
