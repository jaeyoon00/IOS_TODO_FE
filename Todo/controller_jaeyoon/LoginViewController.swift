import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        // 이메일 텍스트 필드 설정
        EmailTextField.attributedPlaceholder = NSAttributedString(
            string: " Email"
        )
        
        // 비밀번호 텍스트 필드 설정
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: " Password"
        )
        // 비밀번호 입력시 **로 표시
        passwordTextField.isSecureTextEntry = true
        
//        // 텍스트 필드에 패딩 추가
//        EmailTextField.addPaddingToTextField()
//        passwordTextField.addPaddingToTextField()
    }
    
    @IBAction func LogIn(_ sender: UIButton) {
        // 로그인 검증은 추후에 구현
        print("로그인 버튼 눌림")
        
        // 로그인 성공 시 로딩 뷰로 이동
        let loadingViewController = LoadingViewController()
        loadingViewController.modalPresentationStyle = .fullScreen
        self.present(loadingViewController, animated: true, completion: nil)
    }
}

//// UIView에 대한 확장
//extension UIView {
//    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 25, height: width)
//        self.layer.addSublayer(border)
//    }
//}
//
//// UITextField에 대한 확장
//extension UITextField {
//    func addPaddingToTextField() {
//        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
//        self.leftView = paddingView
//        self.leftViewMode = .always
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }
//}

