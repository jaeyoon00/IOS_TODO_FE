import UIKit

// MARK: - 내 Todo 목록 테이블 뷰 설정
extension MyTodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 할 일 목록의 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let selectedDate = selectedDate, let formattedSelectedDate = selectedDate.formattedDateString() else {
                return 0
            }
        return myTodoList.filter { $0.todoDate == formattedSelectedDate }.count
    }
    
    // 할 일 목록의 각 행에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTodoCell", for: indexPath)
        guard let selectedDate = selectedDate, let formattedSelectedDate = selectedDate.formattedDateString() else {
            return cell
        }
        let filteredTodoList = myTodoList.filter { $0.todoDate == formattedSelectedDate }
        let todo = filteredTodoList[indexPath.row]
        cell.textLabel?.text = todo.todoTitle
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
    
    // 터치 시 터치 한 Todo의 id 전달 및 print 후 MyTodoDetailController로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedTodo = myTodoList[indexPath.row]
        todoId = selectedTodo.todoId
        print("선택한 Todo의 id: \(selectedTodo.todoId)")
        
        let myTodoDetailVC = MyTodoDetailController(todoId: selectedTodo.todoId)
        myTodoDetailVC.modalPresentationStyle = .formSheet
        self.present(myTodoDetailVC, animated: true, completion: nil)
    }
}
