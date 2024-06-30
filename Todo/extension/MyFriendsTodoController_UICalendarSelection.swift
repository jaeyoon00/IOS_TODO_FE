import UIKit

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
