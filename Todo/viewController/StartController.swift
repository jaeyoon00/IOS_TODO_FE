//
//  StartController.swift
//  Todo
//
//  Created by 김재윤 on 6/4/24.
//

import UIKit
import Lottie

class StartController: UIViewController{
    

    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Lottie 애니메이션 뷰 설정
        animationView = LottieAnimationView(name: "StartAnimation")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .playOnce
        animationView?.animationSpeed = 2.0
        
        self.view.addSubview(animationView!)
        animationView?.play(completion: { [weak self] _ in
            self?.navigateToMainStoryboard()
        })
    }
    private func navigateToMainStoryboard() {
        // Main.storyboard로 전환
        let mainStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "LogInTabBarController") as? UITabBarController {
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true, completion: nil)
        }
    }
}

