import UIKit

class MyFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var MyFriendsView = UITableView()
    var friends: [String] = []
    var friendsId: [Int] = []
    var filteredFriends: [String] = []
    var filteredFriendsId: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMyFriendTitle()
        
        MyFriendsView.dataSource = self
        MyFriendsView.delegate = self
        MyFriendsView.separatorStyle = .none
        MyFriendsView.register(MyFriendCell.self, forCellReuseIdentifier: "MyFriendCell")
        MyFriendsView.backgroundColor = UIColor(named: "mainColor")
        
        view.addSubview(MyFriendsView)
        
        MyFriendsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MyFriendsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            MyFriendsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            MyFriendsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            MyFriendsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        // Fetch friends and update the UI
        fetchFriends()
    }
    
    func fetchFriends() {
        FriendsManager.shared.getAllFriends { [weak self] friends in
            guard let self = self else { return }
            self.friends = friends
            self.friendsId = FriendsManager.shared.friendsId
            self.filteredFriends = friends
            self.filteredFriendsId = self.friendsId
            DispatchQueue.main.async {
                self.MyFriendsView.reloadData()
            }
        }
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
                textLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -200)
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
        let friendId = filteredFriendsId[friendIndex]
        
        FriendsManager.shared.deleteFriend(userId: friendId) { [weak self] message in
            guard let self = self else { return }
            
            if message == "친구 삭제 성공" {
                self.filteredFriends.remove(at: friendIndex)
                self.filteredFriendsId.remove(at: friendIndex)
                self.friends.removeAll { $0 == friendName }
                self.friendsId.removeAll { $0 == friendId }
                
                DispatchQueue.main.async {
                    self.MyFriendsView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
                    self.MyFriendsView.reloadData() //reloadData 안해주면 tag값이 밀려서 삭제 오류 뜸
                }
                
                print("\(friendName)가 친구목록에서 삭제되었습니다")
            } else {
                let alert = UIAlertController(title: "오류", message: "친구 삭제에 실패했습니다. 다시 시도해주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("친구 삭제 실패")
            }
        }
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
