import UIKit
import Lottie

class LoadingViewController: UIViewController {

    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Lottie 애니메이션 뷰 설정
        animationView = LottieAnimationView(name: "StartAnimation")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .playOnce
        animationView?.animationSpeed = 2.0
        animationView?.backgroundColor = .white

        view.addSubview(animationView!)
        animationView?.play(completion: { [weak self] _ in
            self?.navigateToMainStoryboard()
        })
    }

    private func navigateToMainStoryboard() {
        // Main.storyboard로 전환
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as? UITabBarController {
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true, completion: nil)
        }
    }
}

