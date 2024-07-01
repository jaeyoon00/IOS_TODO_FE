import UIKit

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
