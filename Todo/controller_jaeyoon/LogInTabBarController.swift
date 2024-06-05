//
//  LogInTabBarController.swift
//  Todo
//
//  Created by 김재윤 on 6/4/24.
//

import UIKit

class LogInTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
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
    
}

//extension LogInTabBarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return MyTransition2()
//    }
//}

//class MyTransition2: NSObject, UIViewControllerAnimatedTransitioning{
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let fromView = transitionContext.viewController(forKey: .from)?.view
//        let toView = transitionContext.viewController(forKey: .to)?.view
//        
//        let containerView = transitionContext.containerView
//        containerView.addSubview(toView!)
//        
//        toView?.alpha = 0
//        UIView.animate(withDuration: 0.5, animations: {
//            fromView?.alpha = 0
//            toView?.alpha = 1
//        }) { (finished) in
//            transitionContext.completeTransition(true)
//        }
//    }
//}
