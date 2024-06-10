
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var SignUpEmailText: UITextField!
    @IBOutlet weak var SignUpNickNameText: UITextField!
    @IBOutlet weak var SignUpPasswordText: UITextField!
    @IBOutlet weak var SignUpProfileSwitch: UISwitch!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignUpPasswordCheckText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        SignUpEmailText.attributedPlaceholder = NSAttributedString(
            string: "형식에 맞게 작성해주세요",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 10)])
        
        
        SignUpNickNameText.attributedPlaceholder = NSAttributedString(
            string: "4~10자 영어, 숫자로 입력해 주세요",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 10)])
        
        SignUpPasswordText.attributedPlaceholder = NSAttributedString(
            string: "영어, 숫자, 특수문자 포함 8~20자",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 10)])
        
        SignUpPasswordCheckText.attributedPlaceholder = NSAttributedString(
            string: "비밀번호 확인",
            attributes:[.foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 10)])
        
        SignUpPasswordText.isSecureTextEntry = true
        SignUpPasswordCheckText.isSecureTextEntry = true
    }
    
    @IBAction func SignUpButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
