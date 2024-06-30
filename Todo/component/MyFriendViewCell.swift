//
//  FriendCellTableViewCell.swift
//  Todo
//
//  Created by 김재윤 on 6/13/24.
//

import UIKit

class MyFriendCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let calenderButton: UIButton = {
        let button = UIButton(type: .system)
        if let image = UIImage(systemName: "calendar.badge.checkmark") {
            button.setImage(image, for: .normal)
            button.tintColor = .systemPink.withAlphaComponent(0.8)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        if let image = UIImage(systemName: "multiply") {
            button.setImage(image, for: .normal)
            button.tintColor = .systemPink.withAlphaComponent(0.8)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(calenderButton)
        contentView.addSubview(profileImageView)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            calenderButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            calenderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -56),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        contentView.backgroundColor = UIColor(named: "mainColor")
    }
    
    func setProfileImage(image: UIImage?) {
        profileImageView.image = image
    }
}

