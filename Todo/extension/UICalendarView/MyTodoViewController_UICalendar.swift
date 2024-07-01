import UIKit

// MARK: - 캘린더 UI 확장
extension MyTodoViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}

// MARK: - 캘린더 날짜 선택 시 이벤트
extension MyTodoViewController: UICalendarSelectionSingleDateDelegate {
    
    // 날짜 선택 시 이벤트
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
        alert.addAction(UIAlertAction(title: "일정 확인", style: .destructive, handler: { action in
            // 확인 버튼 클릭 시 해당 날짜의 할 일 목록을 불러옴
            self.fetchMyTodoList(for: dateComponents)
        }))
        alert.addAction(UIAlertAction(title: "일정 추가", style: .default, handler: { action in
            // 추가 버튼 클릭 시 MyTodoEnrollController로 이동
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
