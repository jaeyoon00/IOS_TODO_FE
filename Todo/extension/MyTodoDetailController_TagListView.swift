//
//  MyTodoDetailController_TagListView.swift
//  Todo
//
//  Created by 안홍범 on 6/30/24.
//

import Foundation
import TagListView

extension MyTodoDetailController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("선택된 카테고리: \(title)")
        
        for tag in sender.tagViews {
            tag.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        }
        tagView.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        tagView.textColor = .white
        
        // 선택된 카테고리 설정
        switch title {
        case "운동":
            selectedCategory = (id: 1, name: "운동")
        case "스터디":
            selectedCategory = (id: 2, name: "스터디")
        case "취미":
            selectedCategory = (id: 3, name: "취미")
        case "기타":
            selectedCategory = (id: 4, name: "기타")
        default:
            selectedCategory = nil
        }
    }
}
