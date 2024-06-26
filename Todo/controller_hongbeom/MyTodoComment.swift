//
//  MyTodoComment.swift
//  Todo
//
//  Created by 안홍범 on 6/26/24.
//

import Foundation
import Alamofire
import UIKit
import SwiftUI

// MARK: - MyTodoComment

func MytodoComment(){
    
    let MyTodoCommentList = List{
        
        // 개수는 통신으로 받아온 댓글 개수로 설정
        ForEach(0..<3){ item in
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text("닉네임")
                        .font(.headline)
                    Text("댓글 내용")
                        .font(.subheadline)
                }
            }
        }
    }
}
