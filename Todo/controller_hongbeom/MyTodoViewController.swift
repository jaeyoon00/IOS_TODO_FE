import UIKit

class MyTodoViewController: UIViewController {
    
    var selectedDateView: UIView?
    var addButton: UIButton?
    var selectedDate: DateComponents? // 선택된 날짜를 저장하는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCalendar()
        createTodoList()
    }

    func createCalendar() {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        calendarView.calendar = .current
        calendarView.locale = Locale(identifier: "ko_KR") // 한국어 설정
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        calendarView.backgroundColor = .systemBackground
        calendarView.layer.cornerRadius = 15
        calendarView.layer.shadowColor = UIColor.gray.cgColor
        calendarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        calendarView.layer.shadowRadius = 4
        calendarView.layer.shadowOpacity = 0.5

        view.addSubview(calendarView)

        // Contraints 설정
        NSLayoutConstraint.activate([
            calendarView.widthAnchor.constraint(equalToConstant: 350),
            calendarView.heightAnchor.constraint(equalToConstant: 405),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // UICalendarSelectionSingleDate 설정
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
    
    // 캘린더 뷰 아래에 할 일 목록 생성
    func createTodoList(){
        let todoListView = UITableView(frame: .zero, style: .insetGrouped)
        
        todoListView.delegate = self
        todoListView.dataSource = self
        
        todoListView.translatesAutoresizingMaskIntoConstraints = false
        todoListView.backgroundColor = .systemGray6
        todoListView.layer.cornerRadius = 15
        
        view.addSubview(todoListView)
        
        // Contraints 설정
        NSLayoutConstraint.activate([
            todoListView.widthAnchor.constraint(equalToConstant: 350),
            todoListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 420),
            todoListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            todoListView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension MyTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    // 일정 추가 팝업 내용
    func showAddEventPopup(for dateComponents: DateComponents) {
        let alert = UIAlertController(title: "일정 추가", message: "\(dateComponents.year ?? 0)년 \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일의 일정을 추가하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { action in
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

#Preview{
    let vc = MyTodoViewController()
    return vc
}
