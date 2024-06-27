import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel = LoginViewModel() // ViewModel 인스턴스 추가
    private var cancellables = Set<AnyCancellable>() // Combine 구독 관리
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings() // 바인딩 설정
    }
    
    private func setupUI() {
        
        // 이메일 텍스트 필드 설정
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email"
        )
        
        // 비밀번호 텍스트 필드 설정
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password"
        )
        
        // 비밀번호 입력시 **로 표시
        passwordTextField.isSecureTextEntry = true
        
        let passwordMissing = UIButton()
        passwordMissing.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        passwordMissing.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        passwordMissing.translatesAutoresizingMaskIntoConstraints = false
        passwordMissing.backgroundColor = .clear
        passwordMissing.setTitleColor(.black, for: .normal)
        passwordMissing.addTarget(self, action: #selector(passwordMissing(_:)), for: .touchUpInside)
        
        view.addSubview(passwordMissing)
        
        // 비밀번호 찾기 레이아웃 설정
        NSLayoutConstraint.activate([
            passwordMissing.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordMissing.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func setupBindings() {
        // 로그인 성공 여부를 구독
        viewModel.$isLoginSuccessful
            .receive(on: DispatchQueue.main) // UI 업데이트는 메인 스레드에서 수행
            .sink { [weak self] isSuccess in
                if isSuccess {
                    self?.showLoadingView() // 로그인 성공 시 로딩 뷰 표시 //**
                }
            }
            .store(in: &cancellables)
        
        // 오류 메시지를 구독
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main) // UI 업데이트는 메인 스레드에서 수행
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showErrorAlert(message: errorMessage)
                }
            }
            .store(in: &cancellables)
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.postLogin()
    }
    
    private func showLoadingView() { //**
        let loadingViewController = LoadingViewController() //**
        loadingViewController.modalPresentationStyle = .fullScreen //**
        self.present(loadingViewController, animated: true, completion: nil) //**
    } //**
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 비밀번호 찾기 => 이메일 인증
    @objc func passwordMissing(_ sender: UIButton) {
        print("비밀번호 찾기")
        
        // 이메일 확인 alert
        let alert = UIAlertController(title: "이메일 확인", message: "이메일을 입력해주세요", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
            textField.borderStyle = .roundedRect
            textField.tintColor = .systemPink
        }
        
        // 확인 버튼
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            
            // 확인 버튼 눌렀을 때 DB에서 이메일 확인 후 이메일로 확인 메일 전송 (QR코드)
            let email = alert.textFields?[0].text
            print("입력한 이메일: \(email ?? "")")
            
            // 이메일 전송 성공 시
            let successAlert = UIAlertController(title: "이메일 전송 성공", message: "이메일을 확인해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            successAlert.addAction(okAction)
            
            self.present(successAlert, animated: true, completion: nil)
        }
        
        // 취소 버튼
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
