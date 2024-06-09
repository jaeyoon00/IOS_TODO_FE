import UIKit

class MyTodoEnrollController: UIViewController, UITextFieldDelegate {
    var selectedDateComponents: DateComponents?
    private var todoContent: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        todoEnrollCheck()
        todoEnrollContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 텍스트 필드를 첫 번째 응답자로 설정
        todoContent.becomeFirstResponder()
    }
    
    func todoEnrollCheck() {
        if let dateComponents = selectedDateComponents {
            // 날짜 확인용
            print("일정 추가를 위한 선택된 날짜: \(dateComponents.year ?? 0)년 \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일")
        }
        
        // 닫기 버튼 및 추가 버튼 추가
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
        view.addSubview(addButton)
        
        // 버튼 레이아웃 설정
        NSLayoutConstraint.activate([
            // 닫기 버튼 constraint 설정
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 추가 버튼 constraint 설정
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // 화면 닫기 로직
    @objc func closeButtonTapped() {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 일정 추가 로직
    @objc func addButtonTapped() {
        
        // 예를 들어, 일정 추가 시 비동기로 무거운 작업을 수행하도록 합니다.
        DispatchQueue.global(qos: .userInitiated).async {
            
            // 무거운 작업 예시 (네트워크 요청, 데이터베이스 작업 등)
            self.performHeavyTask()
            
            // 메인 스레드에서 UI 업데이트
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // 추후 서버와 연결할 때 사용
    func performHeavyTask() {
        sleep(2)
    }
    
    func todoEnrollContent() {
        // 일정 내용 입력란 추가
        todoContent = UITextField()
        todoContent.placeholder = "내용을 입력하세요."
        todoContent.autocorrectionType = .no
        todoContent.spellCheckingType = .no
        todoContent.borderStyle = .roundedRect
        todoContent.translatesAutoresizingMaskIntoConstraints = false
        todoContent.delegate = self // delegate 설정
        
        view.addSubview(todoContent)
        
        // 일정 내용 입력란 레이아웃 설정
        NSLayoutConstraint.activate([
            todoContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            todoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        DispatchQueue.main.async{
            self.todoContent.becomeFirstResponder()
        }
    }
    
    // UITextFieldDelegate 메서드 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

#Preview {
    MyTodoEnrollController()
}
