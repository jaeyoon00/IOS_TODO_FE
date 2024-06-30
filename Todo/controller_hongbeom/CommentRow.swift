//
//  CommentRow.swift
//  Todo
//
//  Created by 안홍범 on 6/30/24.
//

import SwiftUI

struct CommentRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .foregroundColor(.pink.opacity(0.7))
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.system(size: 15, weight: .bold))
                Text("작성 시간")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("댓글 내용")
                .font(.system(size: 15))
                .foregroundColor(.black)
        }
        .padding(.vertical, 10)
    }
}
