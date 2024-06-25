import UIKit
import Foundation
import SimpleCheckbox
import Alamofire
import TagListView

class MyTodoDetailController: UIViewController {
    
    var myTodoDetail: MyTodoDetail?
    var todoId: Int
    
    // 커스텀 초기화 메소드
    init(todoId: Int) {
        self.todoId = todoId
        super.init(nibName: nil, bundle: nil)
    }
    
    // 필수 초기화 메소드 구현
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchTodoDetailByTodoId(for: todoId)
        MyTodoDetail()
    }
    
    func setupUI() {
        // 취소 버튼
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.backgroundColor = .clear
        cancelButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 수정 버튼
        let updateButton = UIButton(type: .system)
        updateButton.setTitle("수정", for: .normal)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        updateButton.backgroundColor = .clear
        updateButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cancelButton)
        view.addSubview(updateButton)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            updateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // 일정 상세 화면(제목, 내용, 날짜, 완료 여부 체크 박스, 수정 버튼, 삭제 버튼, 댓글)
    func MyTodoDetail() {
        guard let myTodoDetail = myTodoDetail else { return }
        
        let todoDateLabel = UILabel()
        todoDateLabel.translatesAutoresizingMaskIntoConstraints = false
        todoDateLabel.text = myTodoDetail.todoDate
        todoDateLabel.font = .systemFont(ofSize: 15, weight: .thin)
        todoDateLabel.textColor = .black.withAlphaComponent(0.8)
        todoDateLabel.textAlignment = .right
        
        let todoTitleLabel = UILabel()
        todoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        todoTitleLabel.text = "제목"
        todoTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        let myTodoTitle = UITextField()
        myTodoTitle.translatesAutoresizingMaskIntoConstraints = false
        // 통신을 통해 가져온 todo의 제목을 입력
        myTodoTitle.text = myTodoDetail.todoTitle
        myTodoTitle.font = .systemFont(ofSize: 15, weight: .light)
        myTodoTitle.tintColor = .systemPink.withAlphaComponent(0.8)
        myTodoTitle.autocorrectionType = .no
        myTodoTitle.spellCheckingType = .no
        myTodoTitle.borderStyle = .roundedRect
        
        let todoContentLabel = UILabel()
        todoContentLabel.translatesAutoresizingMaskIntoConstraints = false
        todoContentLabel.text = "내용"
        todoContentLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        let myTodoContent = UITextField()
        myTodoContent.translatesAutoresizingMaskIntoConstraints = false
        // 통신을 통해 가져온 todo의 내용을 입력
        myTodoContent.text = myTodoDetail.todoContent
        myTodoContent.font = .systemFont(ofSize: 15, weight: .light)
        myTodoContent.tintColor = .systemPink.withAlphaComponent(0.8)
        myTodoContent.autocorrectionType = .no
        myTodoContent.spellCheckingType = .no
        myTodoContent.borderStyle = .roundedRect
        
        let todoDoneCheckBoxLabel = UILabel()
        todoDoneCheckBoxLabel.translatesAutoresizingMaskIntoConstraints = false
        todoDoneCheckBoxLabel.text = "완료 여부"
        todoDoneCheckBoxLabel.font = .systemFont(ofSize: 15, weight: .black)
        
        let todoDoneCheckBox = Checkbox()
        todoDoneCheckBox.translatesAutoresizingMaskIntoConstraints = false
        todoDoneCheckBox.borderStyle = .circle
        todoDoneCheckBox.checkmarkStyle = .tick
        todoDoneCheckBox.checkmarkColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.uncheckedBorderColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.checkedBorderColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.isChecked = myTodoDetail.todoDone
        
        let category = TagListView()
        
        // 통신으로 받아온 카테고리 리스트를 태그로 추가
        category.addTags(["운동", "스터디", "취미", "기타"])
        category.alignment = .left
        category.textFont = .systemFont(ofSize: 15)
        category.cornerRadius = 10
        category.paddingX = 10
        category.paddingY = 5
        category.marginX = 5
        category.marginY = 5
        category.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.delegate = self
        
        view.addSubview(todoDateLabel)
        view.addSubview(todoTitleLabel)
        view.addSubview(myTodoTitle)
        view.addSubview(todoContentLabel)
        view.addSubview(myTodoContent)
        view.addSubview(todoDoneCheckBoxLabel)
        view.addSubview(todoDoneCheckBox)
        view.addSubview(category)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            todoDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            todoDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todoTitleLabel.topAnchor.constraint(equalTo: todoDateLabel.bottomAnchor, constant: 30),
            todoTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            myTodoTitle.topAnchor.constraint(equalTo: todoTitleLabel.bottomAnchor, constant: 15),
            myTodoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myTodoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todoContentLabel.topAnchor.constraint(equalTo: myTodoTitle.bottomAnchor, constant: 40),
            todoContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            myTodoContent.topAnchor.constraint(equalTo: todoContentLabel.bottomAnchor, constant: 15),
            myTodoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myTodoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todoDoneCheckBoxLabel.topAnchor.constraint(equalTo: myTodoContent.bottomAnchor, constant: 40),
            todoDoneCheckBoxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            todoDoneCheckBox.topAnchor.constraint(equalTo: myTodoContent.bottomAnchor, constant: 35),
            todoDoneCheckBox.leadingAnchor.constraint(equalTo: todoDoneCheckBoxLabel.trailingAnchor, constant: 10),
            todoDoneCheckBox.widthAnchor.constraint(equalToConstant: 30),
            todoDoneCheckBox.heightAnchor.constraint(equalToConstant: 30),
            
            category.topAnchor.constraint(equalTo: todoDoneCheckBox.bottomAnchor, constant: 20),
            category.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            category.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            category.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func fetchTodoDetailByTodoId(for todoId: Int) {
        // todoId를 통해 todo 상세 정보를 가져오는 api 호출
        MyTodoNetworkManager.MyTodoApi.getTodoDetail(todoId: todoId) { result in
            switch result {
            case .success(let myTodoDetail):
                self.myTodoDetail = myTodoDetail
                DispatchQueue.main.async {
                    self.MyTodoDetail()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateButtonTapped() {
        // 수정 버튼 클릭 시 todo 수정 api 호출 후 화면 닫기
    }
    
    // 터치 이벤트 발생 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension MyTodoDetailController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("선택된 카테고리: \(title)")
        
        for tag in sender.tagViews {
            tag.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        }
        tagView.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        tagView.textColor = .white
    }
}

#Preview {
    MyTodoDetailController(todoId: 1) // 임의의 id 값으로 초기화
}
