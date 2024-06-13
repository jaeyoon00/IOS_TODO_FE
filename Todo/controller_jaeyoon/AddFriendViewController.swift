import UIKit

class AddFriendViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    
    let searchController = UISearchController()
    var tableView: UITableView!
    var searchBar: UISearchBar!
    
    var friends = ["김정렬", "김재윤", "박미람","김부자","안홍범", "정희석"]
    var filteredFriends = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendTitle()
        setupSearchBar()
        makeTableView()
        
        // 초기 필터링 결과를 전체 데이터로 설정
        filteredFriends = friends
        
        //searchController 설정
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self // *** 이 줄을 추가하여 searchBar의 delegate를 설정합니다.
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
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = .systemPink
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    private func makeTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    private func addFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "친구추가")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    // UITableViewDataSource 메서드 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 필터링된 데이터의 수를 반환합니다.
        return filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        // 셀의 내용을 필터링된 데이터로 설정합니다.
        cell.textLabel?.text = filteredFriends[indexPath.row]
        return cell
    }
}

// UISearchResultsUpdating 채택
extension AddFriendViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        // 텍스트가 비어있으면 전체 데이터, 아니면 필터링된 데이터로 설정
        filteredFriends = text.isEmpty ? friends : friends.filter { $0.localizedStandardContains(text) }
        
        // 테이블 뷰를 다시 로드
        tableView.reloadData()
    }
}

// UISearchBarDelegate의 searchBarSearchButtonClicked 메서드 추가
extension AddFriendViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드를 내립니다.
        
        // 검색 결과를 필터링
        filteredFriends = searchBar.text?.isEmpty ?? true ? friends : friends.filter { $0.localizedStandardContains(searchBar.text ?? "") }
        
        // 테이블 뷰를 다시 로드
        tableView.reloadData()
    }
}

#Preview {
    let vc = AddFriendViewController()
    return vc
}
