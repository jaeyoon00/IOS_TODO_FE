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
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
                .foregroundColor(.pink.opacity(0.7))
            VStack(alignment: .leading, spacing: 5) {
                Text(comment.content)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                Text(formattedDate(from: comment.createdAt))
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
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

