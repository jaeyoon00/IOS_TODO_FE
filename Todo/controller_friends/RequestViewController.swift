import UIKit

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requestView: UITableView!
    
    var friends: [String] = []
    var friendRequestDates: [[Int]] = []
    var friendRequestIds: [Int] = []
    var filteredFriends: [String] = []
    var filteredFriendRequestDates: [[Int]] = []
    var filteredFriendRequestIds: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UITableView
        requestView = UITableView()
        requestView.dataSource = self
        requestView.delegate = self
        requestView.layer.cornerRadius = 15
        requestView.separatorStyle = .none
        requestView.register(RequestViewCell.self, forCellReuseIdentifier: "RequestViewCell") // Register cell
        requestView.backgroundColor = UIColor(named: "mainColor")
        requestView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestView)
        
        // Set layout constraints
        NSLayoutConstraint.activate([
            requestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        // Add title image
        addRequestFriendTitle()
        
        // Fetch friend requests and update the UI
        fetchFriendRequests()
    }
    
    private func fetchFriendRequests() {
        FriendsManager.shared.getFriendRequests { [weak self] (friendRequests, requestDates, requestIds) in
            guard let self = self else { return }
            self.friends = friendRequests
            self.friendRequestDates = requestDates
            self.friendRequestIds = requestIds
            self.filteredFriends = friendRequests
            self.filteredFriendRequestDates = requestDates
            self.filteredFriendRequestIds = requestIds
            DispatchQueue.main.async {
                self.requestView.reloadData()
            }
        }
    }
    
    private func addRequestFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "ApplicationReceived")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestViewCell", for: indexPath) as! RequestViewCell
        
        let friendName = filteredFriends[indexPath.row]
        cell.setNameText(text: friendName)
        
        // 날짜를 불러온 데이터로 설정
        let requestDateArray = filteredFriendRequestDates[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let requestDate = requestDateArray.toDate() {
            cell.setDateText(text: dateFormatter.string(from: requestDate))
        }
        
        let profileImage = UIImage(named: "profileMain")
        cell.setProfileImage(image: profileImage)
        
        cell.acceptButton.tag = indexPath.row
        cell.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
        
        cell.refuseButton.tag = indexPath.row
        cell.refuseButton.addTarget(self, action: #selector(refuseButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func acceptButtonTapped(_ sender: UIButton) {
        let friendIndex = sender.tag
        let friendName = self.filteredFriends[friendIndex]
        let requestId = self.filteredFriendRequestIds[friendIndex]
        
        FriendsManager.shared.acceptFriendRequest(requestId: requestId, status: true) { [weak self] message in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "친구추가 완료!", message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                // Add friend
                FriendsManager.shared.addFriend(friendName)
                
                // Remove from requests list
                self.filteredFriends.remove(at: friendIndex)
                self.filteredFriendRequestDates.remove(at: friendIndex)
                self.filteredFriendRequestIds.remove(at: friendIndex)
                self.requestView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
                self.requestView.reloadData()
                
                print("\(friendName)님의 친구 요청이 수락되었습니다")
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func refuseButtonTapped(_ sender: UIButton) {
        let friendIndex = sender.tag
        let friendName = filteredFriends[friendIndex]
        let requestId = self.filteredFriendRequestIds[friendIndex]
        
        FriendsManager.shared.acceptFriendRequest(requestId: requestId, status: false) { [weak self] message in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "친구 요청 거절됨", message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                // Remove from requests list
                self.filteredFriends.remove(at: friendIndex)
                self.filteredFriendRequestDates.remove(at: friendIndex)
                self.filteredFriendRequestIds.remove(at: friendIndex)
                self.requestView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
                self.requestView.reloadData()
                
                print("\(friendName)님의 친구 요청이 거절되었습니다")
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
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

extension Array where Element == Int {
    func toDate() -> Date? {
        guard self.count == 6 else { return nil }
        var dateComponents = DateComponents()
        dateComponents.year = self[0]
        dateComponents.month = self[1]
        dateComponents.day = self[2]
        dateComponents.hour = self[3]
        dateComponents.minute = self[4]
        dateComponents.second = self[5]
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}
