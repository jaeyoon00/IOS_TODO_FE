//
//  PasswordEditViewController.swift
//  Todo
//
//  Created by 안홍범 on 6/21/24.
//

import UIKit

class PasswordEditViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        let newPasswordTitleLabel = UILabel()
        newPasswordTitleLabel.text = "비밀번호 변경"
        newPasswordTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        newPasswordTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let emailLabel = UILabel()
        emailLabel.text = "내 이메일"
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let emailTextField = UITextField()
        // disabled 상태로 설정하여 수정 불가능하게 설정
        emailTextField.isEnabled = false
        emailTextField.text = "abc@naver.com"
        emailTextField.textColor = .systemGray
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .systemGray6
        emailTextField.tintColor = .systemPink
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        let newPasswordLabel = UILabel()
        newPasswordLabel.text = "새 비밀번호"
        newPasswordLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        newPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let newPasswordTextField = UITextField()
        newPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "4~10자 영어, 숫자로 입력해 주세요"
        )
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.tintColor = .systemPink
        newPasswordTextField.borderStyle = .roundedRect
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let newPasswordCheckLabel = UILabel()
        newPasswordCheckLabel.text = "새 비밀번호 확인"
        newPasswordCheckLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        newPasswordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let newPasswordCheckTextField = UITextField()
        newPasswordCheckTextField.attributedPlaceholder = NSAttributedString(
            string: "위 비밀번호를 다시 입력해 주세요"
        )
        newPasswordCheckTextField.isSecureTextEntry = true
        newPasswordCheckTextField.borderStyle = .roundedRect
        newPasswordCheckTextField.tintColor = .systemPink
        newPasswordCheckTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let saveButton = UIButton()
        saveButton.setTitle("비밀번호 변경", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemPink.withAlphaComponent(0.7)
        saveButton.layer.cornerRadius = 5
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(newPasswordTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(newPasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordCheckLabel)
        view.addSubview(newPasswordCheckTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            newPasswordTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            newPasswordTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: newPasswordTitleLabel.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            newPasswordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            newPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            newPasswordTextField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 10),
            newPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            newPasswordCheckLabel.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 40),
            newPasswordCheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            newPasswordCheckTextField.topAnchor.constraint(equalTo: newPasswordCheckLabel.bottomAnchor, constant: 10),
            newPasswordCheckTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newPasswordCheckTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: newPasswordCheckTextField.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)

        ])
        
    }
    
    // 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

#Preview{
    PasswordEditViewController()
}
