//
//  MyFriendsController.swift
//  Todo
//
//  Created by 안홍범 on 5/31/24.
//

import UIKit

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var MyFriednsView = UITableView()
    
    var friends: [String] {
        return FriendsManager.shared.getAllFriends()
    }
    var filteredFriends = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMyFriendTitle()
        
        MyFriednsView.dataSource = self
        MyFriednsView.delegate = self
        MyFriednsView.separatorStyle = .none
        MyFriednsView.register(MyFriendCell.self, forCellReuseIdentifier: "MyFriendCell")
        MyFriednsView.backgroundColor = UIColor(named: "mainColor")
        
        view.addSubview(MyFriednsView)
        
        MyFriednsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MyFriednsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            MyFriednsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            MyFriednsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            MyFriednsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        filteredFriends = friends
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendCell
        tableView.layer.cornerRadius = 15
        let friendName = filteredFriends[indexPath.row]
        cell.textLabel?.text = friendName
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        if let textLabel = cell.textLabel {
            NSLayoutConstraint.activate([
                textLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                textLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -220)
            ])
        }
        
        let profileImage = UIImage(named: "profileMain")
        cell.setProfileImage(image: profileImage)
        
        cell.calenderButton.tag = indexPath.row
        cell.calenderButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    private func addMyFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "FriendListMain")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    @objc private func followButtonTapped(_ sender: UIButton) {
        let friendName = filteredFriends[sender.tag]
        print("\(friendName)의 To-Do로 이동합니다.")
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let friendIndex = sender.tag
        let friendName = filteredFriends[friendIndex]
        
        filteredFriends.remove(at: friendIndex)
        FriendsManager.shared.removeFriend(friendName)
        
        MyFriednsView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
        
        MyFriednsView.reloadData() //reloadData 안해주면 tag값이 밀려서 삭제 오류 뜸
        
        print("\(friendName)가 친구목록에서 삭제되었습니다")
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

#Preview {
    let vc = MyFriendsViewController()
    return vc
}
