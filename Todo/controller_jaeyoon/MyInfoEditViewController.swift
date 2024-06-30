import UIKit
import Alamofire

protocol MyInfoEditViewControllerDelegate: AnyObject {
    func didUpdateUserInfo()
}

class MyInfoEditViewController: UIViewController {
    
    weak var delegate: MyInfoEditViewControllerDelegate?

    let nickNameTextField = UITextField()
    let passwordTextField = UITextField()
    let openCheckbox = UISwitch()
    let profileImageView = UIImageView()

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
        
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        nickNameTextField.placeholder = "닉네임을 입력해주세요"
        nickNameTextField.borderStyle = .roundedRect
        nickNameTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        nickNameTextField.tag = 1
        
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "비밀번호 수정"
        passwordLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tag = 2
        
        let passwordCheckLabel = UILabel()
        passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckLabel.text = "비밀번호 확인"
        passwordCheckLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let passwordCheckTextField = UITextField()
        passwordCheckTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckTextField.placeholder = "비밀번호 확인"
        passwordCheckTextField.borderStyle = .roundedRect
        passwordCheckTextField.tintColor = .systemPink.withAlphaComponent(0.8)
        passwordCheckTextField.isSecureTextEntry = true
        
        let opencheckLabel = UILabel()
        opencheckLabel.translatesAutoresizingMaskIntoConstraints = false
        opencheckLabel.text = "계정 비공개 설정"
        opencheckLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        openCheckbox.translatesAutoresizingMaskIntoConstraints = false
        openCheckbox.onTintColor = .systemPink.withAlphaComponent(0.8)
        openCheckbox.tag = 3
        
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
    
    @objc func closeButtonTapped() {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editButtonTapped() {
        view.endEditing(true)
        
        let nickname = nickNameTextField.text?.isEmpty == false ? nickNameTextField.text : nil
        let password = passwordTextField.text?.isEmpty == false ? passwordTextField.text : nil
        let userPublicScope = openCheckbox.isOn
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("No token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "multipart/form-data"
        ]
        
        let profileImageUrl = UserDefaults.standard.string(forKey: "profileImageUrl")
        
        if let profileImageUrl = profileImageUrl, let url = URL(string: profileImageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Image loading error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No image data found")
                    return
                }
                
                AF.upload(multipartFormData: { multipartFormData in
                    if let nickname = nickname {
                        multipartFormData.append(Data(nickname.utf8), withName: "nickname")
                    }
                    if let password = password {
                        multipartFormData.append(Data(password.utf8), withName: "password")
                    }
                    multipartFormData.append(data, withName: "image", fileName: "profile.jpg", mimeType: "image/jpeg")
                    multipartFormData.append(Data("\(userPublicScope)".utf8), withName: "userPublicScope")
                }, to: "http://34.121.86.244:80/users/me", method: .put, headers: headers)
                .validate(statusCode: 200..<300)
                .response { response in
                    print("Full Response: \(response)")
                    switch response.result {
                    case .success(let value):
                        print("Success response data: \(String(describing: value))")
                        DispatchQueue.main.async {
                            self.showSuccessAlert() // 수정 완료 알림 표시
                        }
                    case .failure(let error):
                        if let data = response.data, let errorString = String(data: data, encoding: .utf8) {
                            print("Error Response Data: \(errorString)")
                        }
                        print("Request error: \(error)")
                        print("token: \(token)")
                    }
                }
            }.resume()
        } else {
            AF.upload(multipartFormData: { multipartFormData in
                if let nickname = nickname {
                    multipartFormData.append(Data(nickname.utf8), withName: "nickname")
                }
                if let password = password {
                    multipartFormData.append(Data(password.utf8), withName: "password")
                }
                multipartFormData.append(Data("\(userPublicScope)".utf8), withName: "userPublicScope")
            }, to: "http://34.121.86.244:80/users/me", method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                print("Full Response: \(response)")
                switch response.result {
                case .success(let value):
                    print("Success response data: \(String(describing: value))")
                    self.showSuccessAlert() // 수정 완료 알림 표시
                case .failure(let error):
                    if let data = response.data, let errorString = String(data: data, encoding: .utf8) {
                        print("Error Response Data: \(errorString)")
                    }
                    print("Request error: \(error)")
                    print("token: \(token)")
                }
            }
        }
    }

    private func showSuccessAlert() {
        let alert = UIAlertController(title: "수정 완료", message: "정보가 성공적으로 수정되었습니다!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.delegate?.didUpdateUserInfo()
            self?.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }


    
    @objc func userExitButtonTapped() {
        let alert = UIAlertController(title: "회원 탈퇴", message: "정말 탈퇴 하시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        
        let OkAction = UIAlertAction(title: "네", style: .default) { [weak self] _ in
            self?.performAccountDeletion()
        }
        
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func performAccountDeletion() {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("No token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request("http://34.121.86.244:80/users/me", // 계정 삭제를 위한 API 엔드포인트
                   method: .delete,
                   headers: headers)
        .validate()
        .responseString { response in
            switch response.result {
            case .success(let value):
                print("Success response data: \(value)")
                
                // 성공 알럿
                let successAlert = UIAlertController(title: "회원 탈퇴가 완료되었습니다", message: "다음에 또 이용해주세요!", preferredStyle: .alert)
                let OkAction = UIAlertAction(title: "확인", style: .default) { _ in
                    self.presentLoginTabBarController()
                }
                successAlert.addAction(OkAction)
                self.present(successAlert, animated: true, completion: nil)
                
            case .failure(let error):
                if let data = response.data, let errorString = String(data: data, encoding: .utf8) {
                    print("Error Response Data: \(errorString)")
                    
                    // 오류 알럿
                    let errorAlert = UIAlertController(title: "오류", message: "계정 삭제에 실패했습니다.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
                print("Request error: \(error)")
            }
        }
    }
    
    private func presentLoginTabBarController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        if let loginTabBarController = storyboard.instantiateViewController(withIdentifier: "LoginTabBarController") as? UITabBarController {
            loginTabBarController.modalPresentationStyle = .fullScreen
            self.present(loginTabBarController, animated: true, completion: nil)
        } else {
            print("LoginTabBarController could not be instantiated")
        }
    }
}
