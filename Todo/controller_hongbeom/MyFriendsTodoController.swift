import UIKit

class MyFriendsTodoController: UIViewController {
    
    var selectedDateView: UIView?
    var addButton: UIButton?
    var selectedDate: DateComponents? // 선택된 날짜를 저장하는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myFriendsList()
        createCalendar()
        createTodoList()
    }
    
    // 친구 목록
    func myFriendsList() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 60, height: 75)
        
        let myFriendsListView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        myFriendsListView.delegate = self
        myFriendsListView.dataSource = self
        
        myFriendsListView.translatesAutoresizingMaskIntoConstraints = false
        myFriendsListView.backgroundColor = .systemGray6
        myFriendsListView.layer.cornerRadius = 15
        
        myFriendsListView.register(MyFriendCell.self, forCellWithReuseIdentifier: MyFriendCell.identifier)
        
        view.addSubview(myFriendsListView)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            myFriendsListView.widthAnchor.constraint(equalToConstant: 350),
            myFriendsListView.heightAnchor.constraint(equalToConstant: 90),
            myFriendsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            myFriendsListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // 친구 일정 달력
    func createCalendar(){
        
        let friendTodoCalendarView = UICalendarView()
        friendTodoCalendarView.translatesAutoresizingMaskIntoConstraints = false
        friendTodoCalendarView.calendar = .current
        friendTodoCalendarView.locale = Locale(identifier: "ko_KR") // 한국어 설정
        friendTodoCalendarView.fontDesign = .rounded
        friendTodoCalendarView.delegate = self
        friendTodoCalendarView.backgroundColor = .systemBackground
        friendTodoCalendarView.layer.cornerRadius = 15
        friendTodoCalendarView.layer.shadowColor = UIColor.gray.cgColor
        friendTodoCalendarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        friendTodoCalendarView.layer.shadowRadius = 2
        friendTodoCalendarView.layer.shadowOpacity = 0.5
        
        view.addSubview(friendTodoCalendarView)
        
        //constraints 설정
        NSLayoutConstraint.activate([
            friendTodoCalendarView.widthAnchor.constraint(equalToConstant: 350),
            friendTodoCalendarView.heightAnchor.constraint(equalToConstant: 400),
            friendTodoCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105),
            friendTodoCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        // UICalendarSelectionSingleDate 설정
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        friendTodoCalendarView.selectionBehavior = dateSelection
    }
    
    // 친구 일정 목록
    func createTodoList(){
        let friendTodoListView = UITableView(frame: .zero, style: .insetGrouped)

        friendTodoListView.translatesAutoresizingMaskIntoConstraints = false
        friendTodoListView.backgroundColor = .systemGray6
        friendTodoListView.layer.cornerRadius = 15
        friendTodoListView.delegate = self
        friendTodoListView.dataSource = self
        
        view.addSubview(friendTodoListView)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            friendTodoListView.widthAnchor.constraint(equalToConstant: 350),
            friendTodoListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 515),
            friendTodoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            friendTodoListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

// 친구 목록 CollectionView Delegate, DataSource
extension MyFriendsTodoController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 추후 통신으로 인원 수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFriendCell.identifier, for: indexPath) as? MyFriendCell else {
            fatalError("친구 없음")
        }
        
        // 추후 통신으로 받아온 데이터로 변경
        cell.imageView.image = UIImage(systemName: "person.circle")
        cell.nameLabel.text = "친구 \(indexPath.row + 1)"
        
        return cell
    }
}

extension MyFriendsTodoController: UITableViewDelegate, UITableViewDataSource {
    
    // 할 일 목록의 행 개수 => 추후 통신으로 받아온 데이터의 개수로 변경
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
    
    // 할 일 목록의 각 행에 대한 설정 => 추후 통신으로 받아온 데이터로 변경
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "할 일 \(indexPath.row + 1)"
        return cell
    }
}
extension MyFriendsTodoController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
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
        if let todoListView = view.subviews.compactMap({ $0 as? UITableView }).first {
            todoListView.reloadData()
        }
        
    }
}

#Preview {
    MyFriendsTodoController()
}
