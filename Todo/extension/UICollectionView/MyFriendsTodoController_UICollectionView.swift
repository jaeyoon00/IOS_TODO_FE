import UIKit

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
