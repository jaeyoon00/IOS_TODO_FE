import UIKit
import Alamofire

class MyFriendsTodoController: UIViewController {

    var selectedDateView: UIView?
    var addButton: UIButton?
    var selectedDate: DateComponents? // 선택된 날짜를 저장하는 변수
    var selectedFriendIndexPath: IndexPath? // 선택된 친구의 인덱스
    var selectedFriendId: Int? // 선택된 친구의 ID
    var friends: [String] = [] // 친구 목록 저장 변수
    var friendsId: [Int] = [] // 친구 ID 저장 변수
    var friendsImage: [String] = [] // 친구 이미지 저장 변수
    var noFriendsLabel: UILabel? // 친구 없음 라벨
    var myFriendsListView: UICollectionView!
    var friendTodos: [FriendsTodo] = [] // 친구 일정 저장 변수
    var datesWithEvents: [DateComponents] = [] // 일정이 있는 날짜 저장 변수

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNoFriendsLabel()
        createCalendar()
        createTodoList()

        // 친구 목록 뷰 초기화
        myFriendsListView = createMyFriendsListView()
        view.addSubview(myFriendsListView)

        // Constraints 설정
        NSLayoutConstraint.activate([
            myFriendsListView.widthAnchor.constraint(equalToConstant: 350),
            myFriendsListView.heightAnchor.constraint(equalToConstant: 90),
            myFriendsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myFriendsListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFriends()
    }

    // 친구 없음 라벨 설정
    func setupNoFriendsLabel() {
        noFriendsLabel = UILabel()
        noFriendsLabel?.text = "친구 없음"
        noFriendsLabel?.textColor = .gray
        noFriendsLabel?.textAlignment = .center
        noFriendsLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        noFriendsLabel?.translatesAutoresizingMaskIntoConstraints = false
        noFriendsLabel?.isHidden = true
        view.addSubview(noFriendsLabel!)

        NSLayoutConstraint.activate([
            noFriendsLabel!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFriendsLabel!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
        ])
    }

    // 친구 목록 불러오기
    func fetchFriends() {
        FriendsManager.shared.getAllFriends { [weak self] friends in
            guard let self = self else { return }
            self.friends = friends
            self.friendsId = FriendsManager.shared.friendsId
            self.friendsImage = FriendsManager.shared.friendsImage
            DispatchQueue.main.async {
                if self.friends.isEmpty {
                    self.noFriendsLabel?.isHidden = false
                } else {
                    self.noFriendsLabel?.isHidden = true
                    self.myFriendsListView.reloadData()
                }
            }
        }
    }

    // 친구 목록 뷰 생성
    func createMyFriendsListView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 60, height: 75)

        let myFriendsListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myFriendsListView.delegate = self
        myFriendsListView.dataSource = self
        myFriendsListView.translatesAutoresizingMaskIntoConstraints = false
        myFriendsListView.backgroundColor = .systemPink.withAlphaComponent(0.07)
        myFriendsListView.tintColor = .gray
        myFriendsListView.layer.cornerRadius = 15
        myFriendsListView.register(MyFriendTodoCell.self, forCellWithReuseIdentifier: MyFriendTodoCell.identifier)
        return myFriendsListView
    }

    // 친구 일정 달력
    func createCalendar() {
        let friendTodoCalendarView = UICalendarView()
        friendTodoCalendarView.translatesAutoresizingMaskIntoConstraints = false
        friendTodoCalendarView.calendar = .current
        friendTodoCalendarView.locale = Locale(identifier: "ko_KR") // 한국어 설정
        friendTodoCalendarView.fontDesign = .rounded
        friendTodoCalendarView.delegate = self
        friendTodoCalendarView.backgroundColor = .systemBackground
        friendTodoCalendarView.tintColor = .systemPink.withAlphaComponent(0.7)
        friendTodoCalendarView.layer.cornerRadius = 15
        friendTodoCalendarView.layer.shadowColor = UIColor.gray.cgColor
        friendTodoCalendarView.layer.shadowOffset = CGSize(width: 0, height: 1)
        friendTodoCalendarView.layer.shadowRadius = 2
        friendTodoCalendarView.layer.shadowOpacity = 0.5

        view.addSubview(friendTodoCalendarView)

        // Constraints 설정
        NSLayoutConstraint.activate([
            friendTodoCalendarView.widthAnchor.constraint(equalToConstant: 350),
            friendTodoCalendarView.heightAnchor.constraint(equalToConstant: 410),
            friendTodoCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105),
            friendTodoCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        // UICalendarSelectionSingleDate 설정
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        friendTodoCalendarView.selectionBehavior = dateSelection
    }

    // 친구 일정 목록
    func createTodoList() {
        let friendTodoListView = UITableView(frame: .zero, style: .insetGrouped)
        friendTodoListView.translatesAutoresizingMaskIntoConstraints = false
        friendTodoListView.backgroundColor = .systemPink.withAlphaComponent(0.07)
        friendTodoListView.layer.cornerRadius = 15
        friendTodoListView.delegate = self
        friendTodoListView.dataSource = self
        view.addSubview(friendTodoListView)

        // Constraints 설정
        NSLayoutConstraint.activate([
            friendTodoListView.widthAnchor.constraint(equalToConstant: 350),
            friendTodoListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 520),
            friendTodoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            friendTodoListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // 일정 목록 업데이트
    func updateTodoList(for userId: Int, date: DateComponents) {
        FriendsTodoNetworkManager.FriendsTodoApi.getMyFriendsTodo(for: userId, date: date) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.friendTodos = response.todos
                    self.updateDatesWithEvents()
                case .failure(let error):
                    print("Failed to fetch todos: \(error)")
                    self.friendTodos = []
                }
                self.view.subviews.compactMap { $0 as? UITableView }.first?.reloadData()
            }
        }
    }

    // 일정이 있는 날짜 업데이트
    func updateDatesWithEvents() {
        datesWithEvents = friendTodos.compactMap { todo in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: todo.todoDate) else { return nil }
            return Calendar.current.dateComponents([.year, .month, .day], from: date)
        }
        view.subviews.compactMap { $0 as? UICalendarView }.first?.reloadDecorations(forDateComponents: datesWithEvents, animated: true)
    }
}
