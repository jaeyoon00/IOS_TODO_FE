//
//  FriendsTodoDetail.swift
//  Todo
//
//  Created by 안홍범 on 6/14/24.
//

import UIKit
import SimpleCheckbox

class FriendsTodoDetailController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        FriendsTodoDetail()
    }
    
    // 친구 일정 상세 화면(제목, 내용, 날짜, 완료 여부 체크박스, 댓글)
    // 추후 통신으로 데이터를 받아와서 뷰에 표시할 예정
    func FriendsTodoDetail(){
        
        // 제목 레이블
        let todoTitle = UILabel()
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.text = "Title"
        todoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        // 내용 레이블
        let todoContent = UILabel()
        todoContent.translatesAutoresizingMaskIntoConstraints = false
        todoContent.text = "Content"
        todoContent.numberOfLines = 0
        
        // 날짜 레이블
        let todoDate = UILabel()
        todoDate.translatesAutoresizingMaskIntoConstraints = false
        todoDate.text = "Date"
        todoDate.font = .systemFont(ofSize: 14)
        todoDate.textColor = .gray
        
        // 완료 여부 라벨
        let todoComplete = UILabel()
        todoComplete.translatesAutoresizingMaskIntoConstraints = false
        todoComplete.text = "완료 여부"
        
        // 완료 여부 체크박스
        let todoCheckbox = Checkbox()
        todoCheckbox.translatesAutoresizingMaskIntoConstraints = false
        todoCheckbox.borderStyle = .circle
        todoCheckbox.checkedBorderColor = .systemPink.withAlphaComponent(0.5)
        todoCheckbox.uncheckedBorderColor = .systemPink.withAlphaComponent(0.5)
        todoCheckbox.checkmarkColor = .systemPink.withAlphaComponent(0.7)
        todoCheckbox.checkmarkStyle = .circle
       
        // 댓글 라벨
        let commentLabel = UILabel()
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = "댓글()" // 댓글 개수를 표시할 예정
        commentLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        // 등록된 댓글들을 조회
        
        
        // 댓글 작성 텍스트 필드
        let todoComment = UITextField()
        todoComment.translatesAutoresizingMaskIntoConstraints = false
        todoComment.placeholder = "댓글 내용을 입력해 주세요."
        todoComment.borderStyle = .roundedRect
        todoComment.tintColor = .systemPink.withAlphaComponent(0.6)
        
        // 댓글 추가 버튼
        let commentButton = UIButton()
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.setTitle("등록", for: .normal)
        commentButton.setTitleColor(.systemPink.withAlphaComponent(0.6), for: .normal)
        commentButton.backgroundColor = .systemPink.withAlphaComponent(0.1)
        commentButton.layer.cornerRadius = 5
        commentButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        
        // 서브뷰 추가
        view.addSubview(todoDate)
        view.addSubview(todoTitle)
        view.addSubview(todoContent)
        view.addSubview(todoComplete)
        view.addSubview(todoCheckbox)
        view.addSubview(commentLabel)
        view.addSubview(todoComment)
        view.addSubview(commentButton)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            
            // 날짜 레이블
            todoDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            todoDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 제목 레이블
            todoTitle.topAnchor.constraint(equalTo: todoDate.bottomAnchor, constant: 20),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 내용 레이블
            todoContent.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 20),
            todoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            todoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 완료 여부 레이블
            todoComplete.topAnchor.constraint(equalTo: todoContent.bottomAnchor, constant: 20),
            todoComplete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 완료 여부 체크박스
            todoCheckbox.centerYAnchor.constraint(equalTo: todoComplete.centerYAnchor),
            todoCheckbox.leadingAnchor.constraint(equalTo: todoComplete.trailingAnchor, constant: 10),
            todoCheckbox.widthAnchor.constraint(equalToConstant: 25),
            todoCheckbox.heightAnchor.constraint(equalToConstant: 25),
            
            // 댓글 레이블
            commentLabel.topAnchor.constraint(equalTo: todoComplete.bottomAnchor, constant: 40),
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            
            // 댓글 텍스트 필드
            todoComment.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 20),
            todoComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoComment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            // 댓글 추가 버튼
            commentButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 20),
            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func addComment(){
        print("댓글 추가")
    }
}

#Preview{
    FriendsTodoDetailController()
}
