//
//  FriendsTodoDetail.swift
//  Todo
//
//  Created by 안홍범 on 6/14/24.
//

import UIKit
import SimpleCheckbox
import SwiftUI
import TagListView

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
        todoTitle.text = "TodoTitle"
        todoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        // 내용 레이블
        let todoContent = UILabel()
        todoContent.translatesAutoresizingMaskIntoConstraints = false
        todoContent.text = "TodoContent"
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
        todoCheckbox.checkmarkStyle = .tick
        
        let category = TagListView()
        category.addTag("운동")
        category.alignment = .left
        category.textFont = .systemFont(ofSize: 15)
        category.cornerRadius = 10
        category.paddingX = 10
        category.paddingY = 5
        category.marginX = 5
        category.marginY = 5
        category.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        category.translatesAutoresizingMaskIntoConstraints = false
       
        // 댓글 라벨
        let commentLabel = UILabel()
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = "댓글"
        commentLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
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
        view.addSubview(category)
        view.addSubview(commentLabel)
        
        view.addSubview(todoComment)
        view.addSubview(commentButton)
        
        // SwiftUI의 댓글 리스트 뷰 추가(사용자 사진, 닉네임, 댓글 내용, 작성 시간)
        let commentList = List {
            CommentRow()
            CommentRow()
            CommentRow()
        }
        
        let hostingController = UIHostingController(rootView: commentList)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            
            // 날짜 레이블
            todoDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todoDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 제목 레이블
            todoTitle.topAnchor.constraint(equalTo: todoDate.bottomAnchor, constant: 20),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 카테고리 태그 리스트
            category.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 5),
            category.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            category.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 내용 레이블
            todoContent.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 20),
            todoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 완료 여부 레이블
            todoComplete.topAnchor.constraint(equalTo: todoContent.bottomAnchor, constant: 40),
            todoComplete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 완료 여부 체크박스
            todoCheckbox.centerYAnchor.constraint(equalTo: todoComplete.centerYAnchor),
            todoCheckbox.leadingAnchor.constraint(equalTo: todoComplete.trailingAnchor, constant: 10),
            todoCheckbox.widthAnchor.constraint(equalToConstant: 25),
            todoCheckbox.heightAnchor.constraint(equalToConstant: 25),
            
            // 댓글 레이블
            commentLabel.topAnchor.constraint(equalTo: todoComplete.bottomAnchor, constant: 40),
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // SwiftUI 댓글 리스트
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: todoComment.topAnchor, constant: -20),
            hostingController.view.heightAnchor.constraint(equalToConstant: 380),
            
            // 댓글 텍스트 필드
            todoComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoComment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            todoComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            // 댓글 추가 버튼
            commentButton.centerYAnchor.constraint(equalTo: todoComment.centerYAnchor),
            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func CommentRow() -> some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .foregroundColor(.pink.opacity(0.7))
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.system(size: 15, weight: .bold))
                Text("작성 시간")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("댓글 내용")
                .font(.system(size: 15))
                .foregroundColor(.black)
        }
        .padding(.vertical, 10)
    }
    
    @objc func addComment(){
        print("댓글 추가")
    }
    
    // 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

#Preview{
    FriendsTodoDetailController()
}
