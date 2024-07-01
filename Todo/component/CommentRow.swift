//
//  CommentRow.swift
//  Todo
//
//  Created by 안홍범 on 6/30/24.
//

import SwiftUI

struct CommentRow: View {
    var comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if let imageUrl = comment.image {
                    AsyncImage(url: URL(string: imageUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(comment.nickname)
                        .font(.system(size: 15, weight: .black))
                    Text(comment.content)
                        .font(.system(size: 12, weight: .light))
                }
            }
            Text(formattedDate(from: comment.createdAt))
                .font(.system(size: 10, weight: .thin))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 0)
    }
    
    func formattedDate(from dateArray: [Int]) -> String {
        guard dateArray.count == 6 else { return "Invalid date" }
        
        var dateComponents = DateComponents()
        dateComponents.year = dateArray[0]
        dateComponents.month = dateArray[1]
        dateComponents.day = dateArray[2]
        dateComponents.hour = dateArray[3]
        dateComponents.minute = dateArray[4]
        dateComponents.second = dateArray[5]
        
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        
        return "Invalid date"
    }
}

