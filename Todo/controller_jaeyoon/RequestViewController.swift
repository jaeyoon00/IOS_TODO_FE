//
//  FriendsRequestController.swift
//  Todo
//
//  Created by 안홍범 on 5/31/24.
//

import UIKit

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requestView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView 초기화
        requestView = UITableView()
        requestView.dataSource = self
        requestView.delegate = self
        requestView.separatorStyle = .none
        requestView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 기본 셀 등록
        requestView.backgroundColor = UIColor(named: "mainColor")
        requestView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            requestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        // 제목 이미지 추가
        addRequestFriendTitle()
    }
    
    private func addRequestFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "받은신청")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 예시로 10개의 행을 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)" // 예시로 행 번호를 텍스트로 설정
        return cell
    }
}

#Preview{
    let vc = RequestViewController()
    return vc
}
