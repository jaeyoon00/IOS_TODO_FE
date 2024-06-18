//
//  MyTodoDetail.swift
//  Todo
//
//  Created by 안홍범 on 6/14/24.
//

import UIKit


class MyTodoDetailController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        MyTodoDetail()
    }
    
    // 일정 상세 화면(제목, 내용, 날짜, 완료 여부 체크 박스, 수정 버튼, 삭제 버튼, 댓글)
    func MyTodoDetail(){
        let todoTitle = UILabel()
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.text = "Title"
        todoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        view.addSubview(todoTitle)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            todoTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}

#Preview{
    MyTodoDetailController()
}
