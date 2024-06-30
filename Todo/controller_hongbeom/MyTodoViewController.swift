import UIKit
import Foundation

class MyTodoViewController: UIViewController {
    
    // 할 일 목록을 저장하는 배열(통신)
    var myTodoList: [MyTodo] = []
    
    var selectedDateView: UIView?
    var addButton: UIButton?
    var selectedDate: DateComponents? // 선택된 날짜를 저장하는 변수
    var todoId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        createCalendar()
        createTodoList()
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

    // MARK: - 내 TodoList UI
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
    
    // 통신을 통해 할 일 목록을 받아오는 함수
    func fetchMyTodoList(for date: DateComponents) {
        MyTodoNetworkManager.MyTodoApi.getMyTodoList(for: date) { result in
            switch result {
            case .success(let myTodoList):
                self.myTodoList = myTodoList
                DispatchQueue.main.async {
                    if let todoListView = self.view.subviews.compactMap({ $0 as? UITableView }).first {
                        todoListView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DateComponents {
    func formattedDateString() -> String? {
        guard let year = self.year, let month = self.month, let day = self.day else {
            return nil
        }
        return String(format: "%04d-%02d-%02d", year, month, day)
    }
}
