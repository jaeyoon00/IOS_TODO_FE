import UIKit

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
