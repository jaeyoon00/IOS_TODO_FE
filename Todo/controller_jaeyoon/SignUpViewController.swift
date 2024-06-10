
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
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 99/255.0, alpha: 0.6)]
        )
        
        SignUpNickNameText.attributedPlaceholder = NSAttributedString(
            string: "4~10자 영어, 숫자로 입력해 주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 99/255.0, alpha: 0.6)]
        )
        
        SignUpPasswordText.attributedPlaceholder = NSAttributedString(
            string: "영어, 숫자, 특수문자 포함 8~20자",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 99/255.0, alpha: 0.6)]
        )
        
        SignUpPasswordCheckText.attributedPlaceholder = NSAttributedString(
            string: "비밀번호 확인",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 99/255.0, alpha: 0.6)]
        )
        
        SignUpPasswordText.isSecureTextEntry = true
        SignUpPasswordCheckText.isSecureTextEntry = true
    }
    
    @IBAction func SignUpButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    return vc
}
