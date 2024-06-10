//
//  LoginController.swift
//  Todo
//
//  Created by 안홍범 on 5/30/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 스토리보드 이외의 첫 화면 구성시 여기에서 구현
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func LogIn(_ sender: UIButton) {
        // 로그인 검증은 추후에 구현
        
        // 로그인 성공 시 로딩 뷰로 이동
        let loadingViewController = LoadingViewController()
        loadingViewController.modalPresentationStyle = .fullScreen
        self.present(loadingViewController, animated: true, completion: nil)
    }
}

