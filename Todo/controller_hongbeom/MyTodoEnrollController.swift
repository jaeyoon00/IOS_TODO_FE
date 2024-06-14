import UIKit
import TagListView

class MyTodoEnrollController: UIViewController, UITextFieldDelegate {
    
    var selectedDateComponents: DateComponents?
    private var todoTitleLabel: UILabel!
    
    private var todoTitle: UITextField!
    private var todoContentLabel: UILabel!
    private var todoContent: UITextField!
    private var todoCategoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        todoEnrollCheck()
        todoEnroll()
        todoCaegory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        todoTitle.becomeFirstResponder()
    }
    
    func todoEnrollCheck() {
        if let dateComponents = selectedDateComponents {
            // 날짜 확인용
            print("일정 추가를 위한 선택된 날짜: \(dateComponents.year ?? 0)년 \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일")
        }
        
        // 닫기 버튼 및 추가 버튼 추가
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let todoEnrollTitleLabel = UILabel()
        todoEnrollTitleLabel.text = "ToDo 추가"
        todoEnrollTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        todoEnrollTitleLabel.textColor = .black
        todoEnrollTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
        view.addSubview(addButton)
        view.addSubview(todoEnrollTitleLabel)
        
        // 버튼 레이아웃 설정
        NSLayoutConstraint.activate([
            
            // 닫기 버튼 constraint 설정
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 추가 버튼 constraint 설정
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 일정 추가 레이블 constraint 설정
            todoEnrollTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todoEnrollTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // 화면 닫기 버튼 로직
    @objc func closeButtonTapped() {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 일정 추가 버튼 로직
    @objc func addButtonTapped() {
        
        // 비동기로 통신(일정 추가)실행
        DispatchQueue.global(qos: .userInitiated).async {
            
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
    
    func todoEnroll() {
        
        // 일정 제목 라벨 추가
        todoTitleLabel = UILabel()
        todoTitleLabel.text = "ToDo 제목"
        todoTitleLabel.font = .systemFont(ofSize: 15)
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 일정 제목 입력란 추가
        todoTitle = UITextField()
        todoTitle.placeholder = "제목을 입력하세요."
        todoTitle.tintColor = .systemPink.withAlphaComponent(0.6)
        todoTitle.autocorrectionType = .no
        todoTitle.spellCheckingType = .no
        todoTitle.borderStyle = .roundedRect
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.delegate = self // delegate 설정
        
        // 일정 내용 라벨 추가
        todoContentLabel = UILabel()
        todoContentLabel.text = "ToDo 내용"
        todoContentLabel.font = .systemFont(ofSize: 15)
        todoContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 일정 내용 입력란 추가
        todoContent = UITextField()
        todoContent.placeholder = "내용을 입력하세요."
        todoContent.tintColor = .systemPink.withAlphaComponent(0.6)
        todoContent.autocorrectionType = .no
        todoContent.spellCheckingType = .no
        todoContent.borderStyle = .roundedRect
        todoContent.translatesAutoresizingMaskIntoConstraints = false
        todoContent.delegate = self // delegate 설정
        
        view.addSubview(todoTitleLabel)
        view.addSubview(todoTitle)
        view.addSubview(todoContentLabel)
        view.addSubview(todoContent)
        
        // 일정 내용 입력란 레이아웃 설정
        NSLayoutConstraint.activate([
            
            // 일정 제목 레이블 constraint 설정
            todoTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            todoTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 일정 제목 입력란 constraint 설정
            todoTitle.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 10),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 일정 내용 레이블 constraint 설정
            todoContentLabel.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 40),
            todoContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 일정 내용 입력란 constraint 설정
            todoContent.topAnchor.constraint(equalTo: todoContentLabel.bottomAnchor, constant: 10),
            todoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        DispatchQueue.main.async{
            self.todoContent.becomeFirstResponder()
        }
    }
    
    func todoCaegory() {
        
        // 일정 카테고리 라벨
        todoCategoryLabel = UILabel()
        todoCategoryLabel.text = "ToDo 카테고리"
        todoCategoryLabel.font = .systemFont(ofSize: 15)
        todoCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 일정 카테고리 태그 리스트 추가(ElaWorkshop/TagListView 참고)
        let tagListView = TagListView()
        
        // 추후에 통신으로 받아온 카테고리로 변경
        tagListView.addTags(["운동", "스터디", "취미","기타"])
        tagListView.delegate = self
        tagListView.alignment = .left
        tagListView.textFont = .systemFont(ofSize: 15)
        tagListView.cornerRadius = 10
        tagListView.paddingX = 10
        tagListView.paddingY = 5
        tagListView.marginX = 5
        tagListView.marginY = 5
        tagListView.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        tagListView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(todoCategoryLabel)
        view.addSubview(tagListView)
        
        NSLayoutConstraint.activate([
            todoCategoryLabel.topAnchor.constraint(equalTo: todoContent.bottomAnchor, constant: 40),
            todoCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tagListView.topAnchor.constraint(equalTo: todoCategoryLabel.bottomAnchor, constant: 10),
            tagListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tagListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tagListView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // UITextFieldDelegate 메서드 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension MyTodoEnrollController: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("선택된 카테고리: \(title)")
        
        // 카테고리는 1개만 선택 가능하고 선택한 카테고리만 색을 핑크색으로 변경
        // 추가할 때 선택한 카테고리 정보를 저장하여 서버로 전송
        for tag in sender.tagViews {
            tag.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        }
        tagView.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        tagView.textColor = .white
    }
    
}

#Preview {
    MyTodoEnrollController()
}
