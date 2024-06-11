//
//  addFriend.swift
//  Todo
//
//  Created by 안홍범 on 5/31/24.
//

import UIKit

class AddFriendViewController : UIViewController, UISearchBarDelegate {
    
    let searchController = UISearchController()
    
    var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendTitle()
        // UISearchBar 초기화 및 설정
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        searchBar.showsCancelButton = true
        // 오토레이아웃 설정을 위해 아래 설정 추가
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = .systemPink
        view.addSubview(searchBar)
        // 오토레이아웃 제약 추가
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
    
    func addFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "친구추가")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(titleImage)
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
    }
}
    #Preview{
        let vc = AddFriendViewController()
        return vc
    }

