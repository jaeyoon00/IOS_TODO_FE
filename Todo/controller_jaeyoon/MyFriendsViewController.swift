//
//  MyFriendsController.swift
//  Todo
//
//  Created by 안홍범 on 5/31/24.
//

import UIKit

class MyFriendsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var MyFriednsView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMyFriendTitle()
        
        MyFriednsView.dataSource = self
        MyFriednsView.delegate = self
        MyFriednsView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        view.addSubview(MyFriednsView)
        
        MyFriednsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MyFriednsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            MyFriednsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            MyFriednsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            MyFriednsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
                ])
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
            
        cell.textLabel?.text = "김재윤"
            
        return cell
    }
    private func addMyFriendTitle() {
        let titleImage = UIImageView()
        titleImage.image = UIImage(named: "친구목록")
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
   
}




#Preview {
    let vc = MyFriendsViewController()
    return vc
}
