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
        requestView.layer.cornerRadius = 15
        requestView.separatorStyle = .none
        requestView.register(RequestViewCell.self, forCellReuseIdentifier: "RequestViewCell") //셀 등록
        requestView.backgroundColor = UIColor(named: "mainColor")
        requestView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            requestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
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
        cell.setDateText(text: "2024-06-17")
        
        let profileImage = UIImage(named: "profileMain")
        cell.setProfileImage(image: profileImage)
        
        cell.acceptButton.tag = indexPath.row
        cell.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
        
        cell.refuseButton.tag = indexPath.row
        cell.refuseButton.addTarget(self, action: #selector(refuseButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc private func acceptButtonTapped(_ sender: UIButton) {
//        let friendName = filteredFriends[sender.tag]
//        print("\(friendName)님의 친구 요청이 수락되었습니다")
        
        //친구추가 완료 알럿
        let alert = UIAlertController(title: "친구추가 완료!", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            
            
            let friendIndex = sender.tag
            let friendName = self.filteredFriends[friendIndex]
            
            // 친구 추가
            FriendsManager.shared.addFriend(friendName)
            
            // 받은 신청 목록에서 삭제
            self.filteredFriends.remove(at: friendIndex)
            self.requestView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
            self.requestView.reloadData()
            
            print("\(friendName)님의 친구 요청이 수락되었습니다")
            
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func refuseButtonTapped(_ sender: UIButton) {
        
        let friendIndex = sender.tag
        
        let friendName = filteredFriends[friendIndex]
        
        filteredFriends.remove(at: friendIndex)
        
        friends.removeAll{ $0 == friendName}
        
        requestView.deleteRows(at: [IndexPath(row: friendIndex, section: 0)], with: .automatic)
        
        requestView.reloadData() //reloadData 안해주면 tag값이 밀려서 삭제 오류 뜸
        
        print("\(friendName)님의 친구 요청이 거절되었습니다")
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
    let vc = RequestViewController()
    return vc
}
