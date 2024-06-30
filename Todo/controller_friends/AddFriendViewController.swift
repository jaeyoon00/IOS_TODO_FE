import UIKit

class AddFriendViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let searchController = UISearchController()
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var noResultsLabel: UILabel! // 라벨 추가
    
    var friends = [String]()
    var filteredFriends = [String]()
    var filteredFriendsId = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendTitle()
        setupSearchBar()
        makeTableView()
        setupNoResultsLabel() // 라벨 설정
        
        filteredFriends = friends
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "친구를 검색해보세요!"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "친구를 검색해보세요!"
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        searchBar.showsCancelButton = true
        searchBar.backgroundColor = UIColor(named: "mainColor")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocapitalizationType = .none
        searchBar.tintColor = .systemPink
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func makeTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "mainColor")
        tableView.layer.cornerRadius = 15
        view.addSubview(tableView)
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupNoResultsLabel() {
        noResultsLabel = UILabel()
        noResultsLabel.text = "검색 결과가 없습니다."
        noResultsLabel.textColor = .gray
        noResultsLabel.textAlignment = .center
        noResultsLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        noResultsLabel.isHidden = true
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noResultsLabel)
        
        NSLayoutConstraint.activate([
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "addFriendMain")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    // UITableViewDataSource 메서드 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.textLabel?.text = filteredFriends[indexPath.row]
        tableView.backgroundColor = UIColor(named: "mainColor")
        
        cell.followButton.tag = indexPath.row
        cell.followButton.addTarget(self, action: #selector(followButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // 팔로우 버튼을 눌렀을 때의 동작
    @objc private func followButtonTapped(_ sender: UIButton) {
        let friendName = filteredFriends[sender.tag]
        
        // 팔로우 요청 API 호출
        FriendsNetworkManager.FriendsApi.requestFriend(userId: filteredFriendsId[sender.tag]) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "요청 완료", message: "\(friendName)님에게 친구 요청을 보냈습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Failed to send friend request: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "요청 실패", message: "친구 요청을 보내지 못했습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
}

extension AddFriendViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredFriends = []
            tableView.reloadData()
            noResultsLabel.isHidden = false // 라벨을 표시
            return
        }
        
        // API 호출하여 검색
        FriendsNetworkManager.FriendsApi.searchUser(nickname: text) { [weak self] result in
            switch result {
            case .success(let users):
                self?.filteredFriends = users.map { $0.nickname }
                self?.filteredFriendsId = users.map { $0.userId }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.noResultsLabel.isHidden = !self!.filteredFriends.isEmpty // 결과가 없으면 라벨 표시
                }
            case .failure(let error):
                print("Failed to search users: \(error)")
                DispatchQueue.main.async {
                    self?.filteredFriends = []
                    self?.tableView.reloadData()
                    self?.noResultsLabel.isHidden = false // 실패 시 라벨 표시
                }
            }
        }
    }
}

// 엔터키를 눌렀을 때의 동작 추가
extension AddFriendViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            filteredFriends = []
            tableView.reloadData()
            noResultsLabel.isHidden = false // 라벨을 표시
            return
        }
        
        // API 호출하여 검색
        FriendsNetworkManager.FriendsApi.searchUser(nickname: text) { [weak self] result in
            switch result {
            case .success(let friends):
                self?.filteredFriends = friends.map { $0.nickname }
                self?.filteredFriendsId = friends.map { $0.userId }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.noResultsLabel.isHidden = !self!.filteredFriends.isEmpty // 결과가 없으면 라벨 표시
                }
            case .failure(let error):
                print("Failed to search users: \(error)")
                DispatchQueue.main.async {
                    self?.filteredFriends = []
                    self?.tableView.reloadData()
                    self?.noResultsLabel.isHidden = false // 실패 시 라벨 표시
                }
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

struct Friend: Decodable {
    let nickname: String
}

#Preview {
    let vc = AddFriendViewController()
    return vc
}
