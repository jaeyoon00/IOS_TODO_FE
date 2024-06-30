import UIKit
import TagListView

class MyTodoEnrollController: UIViewController, UITextFieldDelegate {
    
    var myTodoList: [MyTodo] = []
    var selectedDateComponents: DateComponents?
    var selectedCategory: (id: Int, name: String)?
    
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
        
        let todoEnrollTitleLabel = UIImageView()
        todoEnrollTitleLabel.image = UIImage(named: "MyTodoEnroll")
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
            todoEnrollTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            todoEnrollTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todoEnrollTitleLabel.widthAnchor.constraint(equalToConstant: 140),
            todoEnrollTitleLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
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
            
            // 일정 제목 라벨 constraint 설정
            todoTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            todoTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // 일정 제목 입력란 constraint 설정
            todoTitle.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 10),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // 일정 내용 라벨 constraint 설정
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
        let categoryList = ["운동", "스터디", "취미", "기타"]
        tagListView.addTags(categoryList)
        
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
    
    // 화면 닫기 버튼 로직
    @objc func closeButtonTapped() {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 일정 추가 버튼 로직
    @objc func addButtonTapped() {
        postMytodo()
        fetchMyTodoList(for: selectedDateComponents!)
    }
    
    func postMytodo() {
        
        var title = ""
        var content = ""

        DispatchQueue.main.async {
            title = self.todoTitle.text ?? ""
            content = self.todoContent.text ?? ""

            guard !title.isEmpty,
                  !content.isEmpty,
                  let dateComponents = self.selectedDateComponents,
                  let category = self.selectedCategory else {
                
                // 필수 필드가 비어 있으면 경고 메시지 표시
                let alert = UIAlertController(title: "오류", message: "모든 내용을 입력하세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            // 날짜 포맷팅
            let formattedDate = String(format: "%04d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)

            // 새로운 할 일 객체 생성
            let newTodo = MyTodoPost(categoryId: category.id, todoTitle: title, todoContent: content, todoDate: formattedDate)

            // 네트워크 매니저를 사용하여 API 호출
            MyTodoNetworkManager.MyTodoApi.postMyTodo(MyTodoPost: newTodo) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        // 할 일 추가 성공 시 UI 업데이트 또는 메시지 표시
                        let alert = UIAlertController(title: "성공", message: "할 일이 추가되었습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {
                            action in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    case .failure(let error):
                        // 할 일 추가 실패 시 오류 메시지 표시
                        let alert = UIAlertController(title: "오류", message: "할 일 추가에 실패했습니다. \(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {
                            action in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func fetchMyTodoList(for date: DateComponents){
        MyTodoNetworkManager.MyTodoApi.getMyTodoList(for: date) { result in
            switch result {
            case .success(let myTodoList):
                self.myTodoList = myTodoList
                DispatchQueue.main.async {
                    if let todoListView = self.view.subviews.compactMap({ $0 as? UITableView }).first {
                        todoListView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
        
        for tag in sender.tagViews {
            tag.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        }
        tagView.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        tagView.textColor = .white
        
        // 선택된 카테고리 설정
        switch title {
        case "운동":
            selectedCategory = (id: 1, name: "운동")
        case "스터디":
            selectedCategory = (id: 2, name: "스터디")
        case "취미":
            selectedCategory = (id: 3, name: "취미")
        case "기타":
            selectedCategory = (id: 4, name: "기타")
        default:
            selectedCategory = nil
        }
    }
}

#Preview {
    MyTodoEnrollController()
}
