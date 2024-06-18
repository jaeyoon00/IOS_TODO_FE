//
//  MyInfoEditController.swift
//  Todo
//
//  Created by 안홍범 on 6/2/24.
//

import UIKit
import SimpleCheckbox

class MyInfoEditViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        MyInfoEdit()
    }
    func MyInfoEdit(){
        
        let myInfoEdit = UILabel()
        myInfoEdit.translatesAutoresizingMaskIntoConstraints = false
        myInfoEdit.text = "내 정보 수정"
        myInfoEdit.font = .systemFont(ofSize: 20, weight: .bold)
        
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
        opencheckLabel.text = "비공개 설정"
        opencheckLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        let openCheckbox = Checkbox()
        openCheckbox.translatesAutoresizingMaskIntoConstraints = false
        openCheckbox.borderStyle = .circle
        openCheckbox.checkedBorderColor = .systemPink.withAlphaComponent(0.5)
        openCheckbox.uncheckedBorderColor = .systemPink.withAlphaComponent(0.5)
        openCheckbox.checkmarkColor = .systemPink.withAlphaComponent(0.7)
        openCheckbox.checkmarkStyle = .tick
        openCheckbox.isChecked = true
    
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
            myInfoEdit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            myInfoEdit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            myInfoExitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myInfoExitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            myInfoEditButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myInfoEditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nickNameLabel.topAnchor.constraint(equalTo: myInfoEdit.bottomAnchor, constant: 40),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nickNameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 20),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordCheckLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            passwordCheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordCheckLabel.bottomAnchor, constant: 20),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordCheckTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            opencheckLabel.topAnchor.constraint(equalTo: passwordCheckTextField.bottomAnchor, constant: 40),
            opencheckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            openCheckbox.centerYAnchor.constraint(equalTo: opencheckLabel.centerYAnchor),
            openCheckbox.leadingAnchor.constraint(equalTo: opencheckLabel.trailingAnchor, constant: 10),
            openCheckbox.widthAnchor.constraint(equalToConstant: 25),
            openCheckbox.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    // 닫기 버튼 터치 이벤트
    @objc func closeButtonTapped(){
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 수정 버튼 터치 이벤트
    @objc func editButtonTapped(){
        view.endEditing(true)
        // 수정 버튼 클릭 시 서버로 수정된 정보 전송
        
    }
    
    // 다른 곳 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

#Preview{
    MyInfoEditViewController()
}
