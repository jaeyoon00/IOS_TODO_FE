import UIKit

class MyTodoViewController: UIViewController {
    
    // 할 일 목록을 저장하는 배열(통신)
    var myTodoList: [MyTodo] = []
    
    var selectedDateView: UIView?
    var addButton: UIButton?
    var selectedDate: DateComponents? // 선택된 날짜를 저장하는 변수
    
    // 당겨서 새로고침
    let refresh = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCalendar()
        createTodoList()
        fetchMyTodoList()
        self.initRefresh()
    }

    // MARK: - 캘린더 UI
    func createCalendar() {
        
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        calendarView.calendar = .current
        calendarView.locale = Locale(identifier: "ko_KR") // 한국어 설정
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.backgroundColor = .systemBackground
        calendarView.tintColor = .systemPink.withAlphaComponent(0.7)
        calendarView.layer.cornerRadius = 15
        calendarView.layer.shadowColor = UIColor.gray.cgColor
        calendarView.layer.shadowOffset = CGSize(width: 0, height: 1)
        calendarView.layer.shadowRadius = 2
        calendarView.layer.shadowOpacity = 0.5

        view.addSubview(calendarView)

        // Contraints 설정
        NSLayoutConstraint.activate([
            calendarView.widthAnchor.constraint(equalToConstant: 350),
            calendarView.heightAnchor.constraint(equalToConstant
                                                 : 405),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // UICalendarSelectionSingleDate 설정
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }

    // MARK: - 내 TodoList 목록
    func createTodoList(){
        let todoListView = UITableView(frame: .zero, style: .insetGrouped)
        
        todoListView.delegate = self
        todoListView.dataSource = self
        
        todoListView.translatesAutoresizingMaskIntoConstraints = false
        todoListView.backgroundColor = .systemPink.withAlphaComponent(0.07)
        todoListView.layer.cornerRadius = 15
        todoListView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTodoCell")
        
        view.addSubview(todoListView)
        
        // Contraints 설정
        NSLayoutConstraint.activate([
            todoListView.widthAnchor.constraint(equalToConstant: 350),
            todoListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 420),
            todoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            todoListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func fetchMyTodoList() {
        // 통신을 통해 할 일 목록을 받아오는 함수
        MyTodoNetworkManager.MyTodoApi.getMyTodoList() { result in
            switch result {
            case .success(let myTodoList):
                self.myTodoList = myTodoList
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - 내 Todo 목록 테이블 뷰 설정
extension MyTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 할 일 목록의 행 개수 =>
    // 추후 통신으로 받아온 데이터의 개수로 변경
    // 날짜별로 할 일 목록을 받아와야 함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: Date())
        return myTodoList.filter { $0.todoDate == selectedDate }.count
    }
    
    // 할 일 목록의 각 행에 대한 설정 =>
    // 추후 통신으로 받아온 데이터로 변경
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTodoCell", for: indexPath)
        let myTodo = myTodoList[indexPath.row]
        cell.textLabel?.text = myTodo.todoTitle
        return cell
    }
    
    // table 제목 => 캘린더에서 터치한 날짜
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let selectedDate = selectedDate else {
            return "날짜가 선택되지 않았습니다"
        }
        
        // ?? 0 => nil이면 0으로 처리
        let year = selectedDate.year ?? 0
        let month = selectedDate.month ?? 0
        let day = selectedDate.day ?? 0
        
        return "\(year)-\(month)-\(day)"
    }
    
    // MARK: 각 셀 터치 시 이벤트 => 추후 터치 시 상세 화면(MyTodoDetailController)으로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myTodoDetailVC = MyTodoDetailController()
        myTodoDetailVC.modalPresentationStyle = .formSheet
        self.present(myTodoDetailVC, animated: true, completion: nil)
    }

}

extension MyTodoViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}

extension MyTodoViewController: UICalendarSelectionSingleDateDelegate {
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
        
        // 일정 추가 팝업 버튼 표시
        showAddEventPopup(for: dateComponents)
        
        // 선택된 날짜가 변경되었으므로 테이블 뷰를 업데이트
        if let todoListView = view.subviews.compactMap({ $0 as? UITableView }).first {
            todoListView.reloadData()
        }
    }
    
    // MARK: 일정 추가 팝업 내용
    func showAddEventPopup(for dateComponents: DateComponents) {
        let alert = UIAlertController(title: "일정 추가", message: "\(dateComponents.year ?? 0)년 \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "일정 확인", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "일정 추가", style: .default, handler: { action in
            // 추가 버튼 클릭 시 MyTodoEnrollController를 모달 형식으로 띄우기
            self.presentMyTodoEnrollViewController(for: dateComponents)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 추가 버튼 터치 시 MyTodoEnrollController로 이동
    func presentMyTodoEnrollViewController(for dateComponents: DateComponents) {
        let storyboard = UIStoryboard(name: "MyTodoEnroll", bundle: nil)
        if let myTodoEnrollVC = storyboard.instantiateViewController(withIdentifier: "MyTodoEnroll") as? MyTodoEnrollController {
            myTodoEnrollVC.modalPresentationStyle = .formSheet
            myTodoEnrollVC.selectedDateComponents = dateComponents // 선택된 날짜 전달
            self.present(myTodoEnrollVC, animated: true, completion: nil)
        }
    }
}
// MARK: - 당겨서 새로고침
extension MyTodoViewController {
    func initRefresh() {
        refresh.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        if let todoListView = view.subviews.compactMap({ $0 as? UITableView }).first {
            todoListView.refreshControl = refresh
        }
    }
    
    @objc func refreshData(refresh: UIRefreshControl) {
        
        // 통신을 통해 할 일 목록을 받아오는 함수
        // MyTodoApi.shared.getMyTodoList { result in
        //     switch result {
        //     case .success(let myTodoList):
        //         self.myTodoList = myTodoList
        //     case .failure(let error):
        //         print(error)
        //     }
        // }
        
        // 새로고침 종료
        print("새로고침 완료")
        refresh.endRefreshing()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y < -0.1) {
                self.refreshData(refresh: self.refresh)
        }
    }
}

#Preview{
    let vc = MyTodoViewController()
    return vc
}
