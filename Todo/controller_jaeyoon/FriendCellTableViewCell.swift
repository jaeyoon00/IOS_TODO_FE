//
//  FriendCellTableViewCell.swift
//  Todo
//
//  Created by 김재윤 on 6/13/24.
//

import UIKit

class FriendCell: UITableViewCell {
    
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("err")
    }
    
    private func setupCell() {
        contentView.addSubview(followButton)
        
        NSLayoutConstraint.activate([
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        contentView.backgroundColor = UIColor(named: "mainColor")
 
    }
}

