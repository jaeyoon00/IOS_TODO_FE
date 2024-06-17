//
//  FriendsRequestController.swift
//  Todo
//
//  Created by 안홍범 on 5/31/24.
//

import UIKit

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requestView: UITableView!
    
    var friends = ["김정렬", "김재윤", "박미람","김부자","안홍범", "정희석"]
    var filteredFriends = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView 초기화
        requestView = UITableView()
        requestView.dataSource = self
        requestView.delegate = self
        requestView.separatorStyle = .none
        requestView.register(RequestViewCell.self, forCellReuseIdentifier: "RequestViewCell") //셀 등록
        requestView.backgroundColor = UIColor(named: "mainColor")
        requestView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            requestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        filteredFriends = friends
        // 제목 이미지 추가
        addRequestFriendTitle()
    }
    
    private func addRequestFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "받은신청")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
        tableView.layer.cornerRadius = 15
        
        let friendName = filteredFriends[indexPath.row]
        cell.setNameText(text: friendName)
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                cell.textLabel!.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -220),
                cell.textLabel!.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
        
        let profileImage = UIImage(named: "프로필")
        cell.profileImageView.image = profileImage
        
        cell.acceptButton.tag = indexPath.row
        cell.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
        
        cell.refuseButton.tag = indexPath.row
        cell.refuseButton.addTarget(self, action: #selector(refuseButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func acceptButtonTapped(_ sender: UIButton) {
        let friendName = filteredFriends[sender.tag]
        print("\(friendName)님의 친구 요청이 수락되었습니다")
    }
    
    @objc private func refuseButtonTapped(_ sender: UIButton) {
        let friendName = filteredFriends[sender.tag]
        print("\(friendName)님의 친구 요청이 거절되었습니다")
    }
}

#Preview{
    let vc = RequestViewController()
    return vc
}
