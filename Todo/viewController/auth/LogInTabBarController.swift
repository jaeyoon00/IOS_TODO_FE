//
//  LogInTabBarController.swift
//  Todo
//
//  Created by 김재윤 on 6/4/24.
//

import UIKit
import SwiftUI

class LogInTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = .systemPink
        
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc private func swipeGesture(swipe: UISwipeGestureRecognizer){
        switch swipe.direction {
        case .right:
            if selectedIndex > 0{
                self.selectedIndex -= 1
            }
            break
        case .left:
            if selectedIndex < (self.viewControllers?.count)! - 1{
                self.selectedIndex += 1
            }
            break
        default:
            break
        }
    }
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


