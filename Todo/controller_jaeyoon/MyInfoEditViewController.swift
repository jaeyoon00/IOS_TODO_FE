import UIKit
import SimpleCheckbox

class MyInfoEditViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        MyInfoEdit()
    }
    
    func MyInfoEdit() {
        
        let myInfoEdit = UIImageView()
        myInfoEdit.image = UIImage(named: "MyInfoEdit")
        myInfoEdit.translatesAutoresizingMaskIntoConstraints = false
        
        let myInfoExitButton = UIButton()
        myInfoExitButton.translatesAutoresizingMaskIntoConstraints = false
        myInfoExitButton.setTitle("닫기", for: .normal)
        myInfoExitButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        myInfoExitButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        let myInfoEditButton = UIButton()
        myInfoEditButton.translatesAutoresizingMaskIntoConstraints = false
        myInfoEditButton.setTitle("수정", for: .normal)
        myInfoEditButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        myInfoEditButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        let nickNameLabel = UILabel()
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.text = "닉네임 수정"
        nickNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let nickNameTextField = UITextField()
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        nickNameTextField.placeholder = "닉네임을 입력해주세요"
        nickNameTextField.borderStyle = .roundedRect
        nickNameTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "비밀번호 수정"
        passwordLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        
        let passwordCheckLabel = UILabel()
        passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckLabel.text = "비밀번호 확인"
        passwordCheckLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let passwordCheckTextField = UITextField()
        passwordCheckTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckTextField.placeholder = "비밀번호 확인"
        passwordCheckTextField.borderStyle = .roundedRect
        passwordCheckTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        
        let opencheckLabel = UILabel()
        opencheckLabel.translatesAutoresizingMaskIntoConstraints = false
        opencheckLabel.text = "계정 비공개 설정"
        opencheckLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let openCheckbox = UISwitch()
        openCheckbox.translatesAutoresizingMaskIntoConstraints = false
        openCheckbox.onTintColor = .systemPink.withAlphaComponent(0.8)
        
        let userExitButton = UIButton()
        userExitButton.translatesAutoresizingMaskIntoConstraints = false
        userExitButton.setTitle("회원탈퇴", for: .normal)
        userExitButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        userExitButton.addTarget(self, action: #selector(userExitButtonTapped), for: .touchUpInside)
               
        view.addSubview(userExitButton)
        
        view.addSubview(myInfoEdit)
        view.addSubview(myInfoExitButton)
        view.addSubview(myInfoEditButton)
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordCheckLabel)
        view.addSubview(passwordCheckTextField)
        view.addSubview(opencheckLabel)
        view.addSubview(openCheckbox)
        
        NSLayoutConstraint.activate([
            // 상단 바 Constraints 설정
            myInfoEdit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            myInfoEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myInfoEdit.widthAnchor.constraint(equalToConstant: 150),
            myInfoEdit.heightAnchor.constraint(equalToConstant: 36),
            
            myInfoExitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myInfoExitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            myInfoEditButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myInfoEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            userExitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600),
            userExitButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            // 닉네임 수정 Contraints 설정
            nickNameLabel.topAnchor.constraint(equalTo: myInfoEdit.bottomAnchor, constant: 40),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nickNameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 20),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 비밀번호 수정 Constraints 설정
            passwordLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 비밀번호 확인 Constraints 설정
            passwordCheckLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 20),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordCheckTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 계정 비공개 설정 Constraints 설정
            opencheckLabel.topAnchor.constraint(equalTo: passwordCheckTextField.bottomAnchor, constant: 40),
            opencheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            openCheckbox.centerYAnchor.constraint(equalTo: opencheckLabel.centerYAnchor),
            openCheckbox.leadingAnchor.constraint(equalTo: opencheckLabel.trailingAnchor, constant: 10),
        ])
    }
    
    // 닫기 버튼 터치 이벤트
    @objc func closeButtonTapped() {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 수정 버튼 터치 이벤트
    @objc func editButtonTapped() {
        view.endEditing(true)
        // 수정 버튼 클릭 시 서버로 수정된 정보 전송
    }
    
    // 다른 곳 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @objc func userExitButtonTapped() {
        let alert = UIAlertController(title: "회원 탈퇴", message: "정말 탈퇴 하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        
        let OkAction = UIAlertAction(title: "네", style: .default) {
            (action) in
            let successAlert = UIAlertController(title: "회원 탈퇴가 완료되었습니다", message: "다음에 또 이용해주세요!", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "확인", style: .default){
                (Action) in
                self.presentLonginTabBarController()
            }
            successAlert.addAction(OkAction)
            self.present(successAlert, animated: true, completion: nil)
        }
        
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
        
        private func presentLonginTabBarController() {
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
    }

#Preview {
    MyInfoEditViewController()
}
