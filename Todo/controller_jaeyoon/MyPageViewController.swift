//
//  MyPageViewController.swift
//  Todo
//
//  Created by 안홍범 on 6/2/24.
//

import UIKit

class MyPageViewController: UIViewController{
    
    @IBOutlet weak var NickName: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    
    
    @IBAction func LogOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "로그아웃 완료!", message: nil, preferredStyle: .alert)
        let Ok = UIAlertAction(title: "확인", style: .default){
            (action) in
            self.goHome()
        }
        alert.addAction(Ok)
        self.present(alert, animated: true)
    }
    
    func goHome() {
        // 스토리보드 인스턴스화
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        // LoginTabBarController 인스턴스화
        if let loginTabBarController = storyboard.instantiateViewController(withIdentifier: "LoginTabBarController") as? UITabBarController {
            
            // LoginTabBarController를 표시
            loginTabBarController.modalPresentationStyle = .fullScreen
            self.present(loginTabBarController, animated: true, completion: nil)
        } else {
            print("LoginTabBarController could not be instantiated")
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private func setupUI() {
    
    
}
