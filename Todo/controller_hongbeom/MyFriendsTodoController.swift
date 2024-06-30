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

// 친구 목록 CollectionView Delegate, DataSource
extension MyFriendsTodoController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFriendTodoCell.identifier, for: indexPath) as? MyFriendTodoCell else {
            fatalError("친구 없음")
        }

        let friendName = friends[indexPath.row]

        // 친구 이름 설정
        cell.nameLabel.text = friendName

        // 아이콘의 색상 변경
        if indexPath == selectedFriendIndexPath {
            cell.imageView.tintColor = .systemPink
        } else {
            cell.imageView.tintColor = .gray
        }

        cell.imageView.image = UIImage(systemName: "person.circle.fill")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 셀이 이미 선택된 상태인지 확인
        if selectedFriendIndexPath == indexPath {
            // 선택된 상태에서 다시 클릭했을 때 색상을 원래대로 돌림
            let selectedCell = collectionView.cellForItem(at: indexPath) as? MyFriendTodoCell
            selectedCell?.imageView.tintColor = .gray
            selectedFriendIndexPath = nil
            selectedFriendId = nil
        } else {
            // 이전 선택된 셀의 아이콘 색상을 원래대로 돌림
            if let previousIndexPath = selectedFriendIndexPath {
                let previousCell = collectionView.cellForItem(at: previousIndexPath) as? MyFriendTodoCell
                previousCell?.imageView.tintColor = .gray
            }

            // 현재 선택된 셀의 아이콘 색상을 변경
            let selectedCell = collectionView.cellForItem(at: indexPath) as? MyFriendTodoCell
            selectedCell?.imageView.tintColor = .systemPink

            // 선택된 셀의 인덱스를 저장
            selectedFriendIndexPath = indexPath
            selectedFriendId = friendsId[indexPath.row]
        }

        // 선택된 날짜가 있는 경우 일정 목록을 업데이트
        if let selectedDate = selectedDate, let selectedFriendId = selectedFriendId {
            updateTodoList(for: selectedFriendId, date: selectedDate)
        }
    }
}

extension MyFriendsTodoController: UITableViewDelegate, UITableViewDataSource {

    // 할 일 목록의 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendTodos.count
    }

    // table 제목 => 캘린더에서 터치한 날짜
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let selectedDate = selectedDate else {
            return "날짜가 선택되지 않았습니다"
        }

        let year = selectedDate.year ?? 0
        let month = selectedDate.month ?? 0
        let day = selectedDate.day ?? 0

        return "\(year)년 \(month)월 \(day)일"
    }

    // 할 일 목록의 각 행에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let todo = friendTodos[indexPath.row]
        cell.textLabel?.text = todo.todoTitle
        return cell
    }

    // 각 셀 터치 시 이벤트 => 추후 터치 시 상세 화면(FriendsTodoDetailController)으로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = friendTodos[indexPath.row]
        let friendsTodoDetailVC = FriendsTodoDetailController(todoId: todo.todoId)
        friendsTodoDetailVC.modalPresentationStyle = .formSheet
        self.present(friendsTodoDetailVC, animated: true, completion: nil)
    }
}

extension MyFriendsTodoController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if datesWithEvents.contains(where: { $0.year == dateComponents.year && $0.month == dateComponents.month && $0.day == dateComponents.day }) {
            return .customView {
                let dotView = UIView()
                dotView.backgroundColor = .systemPink
                dotView.layer.cornerRadius = 2.5
                dotView.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
                return dotView
            }
        }
        return nil
    }
}

extension MyFriendsTodoController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents else { return }

        // 선택된 날짜를 저장
        selectedDate = dateComponents

        // 년, 월, 일을 출력(확인용)
        print("해당 날짜: \(dateComponents.year ?? 0)년 \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일")

        // 이전 선택된 날짜의 표시 제거
        selectedDateView?.removeFromSuperview()

        // 새로운 선택된 날짜에 대한 표시 추가
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        selectionView.layer.cornerRadius = 15
        selectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(selectionView)
        selectedDateView = selectionView

        // 선택된 날짜가 변경되었으므로 테이블 뷰를 업데이트
        if let selectedFriendId = selectedFriendId {
            updateTodoList(for: selectedFriendId, date: dateComponents)
        }
    }
}

#Preview {
    MyFriendsTodoController()
}
