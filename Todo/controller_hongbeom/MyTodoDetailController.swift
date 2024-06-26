import UIKit
import Foundation
import SimpleCheckbox
import Alamofire
import TagListView

class MyTodoDetailController: UIViewController {
    
    var myTodoDetail: MyTodoDetail?
    var myTodoUpdate: MyTodoUpdate?
    var todoId: Int?
    var selectedCategory: (id: Int, name: String)?
    
    private var myTodoTitle: UITextField!
    private var myTodoContent: UITextField!
    private var todoDoneCheckBox: Checkbox!
    
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
        fetchTodoDetailByTodoId(for: todoId!)
        MyTodoDetail()
    }
    
    func setupUI() {
        
        // 취소 버튼
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.backgroundColor = .clear
        deleteButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 수정 버튼
        let updateButton = UIButton(type: .system)
        updateButton.setTitle("수정", for: .normal)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        updateButton.backgroundColor = .clear
        updateButton.setTitleColor(.systemPink.withAlphaComponent(0.8), for: .normal)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(deleteButton)
        view.addSubview(updateButton)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            updateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
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
        
        myTodoTitle = UITextField()
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
        
        myTodoContent = UITextField()
        myTodoContent.translatesAutoresizingMaskIntoConstraints = false
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
        
        todoDoneCheckBox = Checkbox()
        todoDoneCheckBox.translatesAutoresizingMaskIntoConstraints = false
        todoDoneCheckBox.borderStyle = .circle
        todoDoneCheckBox.checkmarkStyle = .tick
        todoDoneCheckBox.checkmarkColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.uncheckedBorderColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.checkedBorderColor = .systemPink.withAlphaComponent(0.8)
        todoDoneCheckBox.isChecked = myTodoDetail.todoDone
        
        let categoryTagListView = TagListView()
        let categoryList = ["운동", "스터디", "취미", "기타"]
        // 통신으로 받아온 카테고리 리스트를 태그로 추가
        categoryTagListView.addTags(categoryList)
        categoryTagListView.alignment = .left
        categoryTagListView.textFont = .systemFont(ofSize: 15)
        categoryTagListView.cornerRadius = 10
        categoryTagListView.paddingX = 10
        categoryTagListView.paddingY = 5
        categoryTagListView.marginX = 5
        categoryTagListView.marginY = 5
        categoryTagListView.tagBackgroundColor = .systemGray.withAlphaComponent(0.6)
        let selectedTag = categoryTagListView.tagViews[myTodoDetail.categoryId - 1]
        selectedTag.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        
        categoryTagListView.translatesAutoresizingMaskIntoConstraints = false
        categoryTagListView.delegate = self
        
        view.addSubview(todoDateLabel)
        view.addSubview(todoTitleLabel)
        view.addSubview(myTodoTitle)
        view.addSubview(todoContentLabel)
        view.addSubview(myTodoContent)
        view.addSubview(todoDoneCheckBoxLabel)
        view.addSubview(todoDoneCheckBox)
        view.addSubview(categoryTagListView)
        
        // Constraints 설정
        NSLayoutConstraint.activate([
            todoDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            todoDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todoTitleLabel.topAnchor.constraint(equalTo: todoDateLabel.bottomAnchor, constant: 20),
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
            
            categoryTagListView.topAnchor.constraint(equalTo: todoDoneCheckBox.bottomAnchor, constant: 20),
            categoryTagListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryTagListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryTagListView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    // 삭제 버튼
    // 삭제 확인 alert 후 확인버튼 누르면 삭제 api 호출 후 화면 닫기
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "삭제", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
            self.deleteTodoByTodoId(for: self.todoId!)
            // 삭제 성공 시 화면 닫기
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 수정 버튼 클릭 시 todo 수정 api 호출 후 화면 닫기
    @objc func updateButtonTapped() {
        updateTodoByTodoId(for: todoId!)
    }
    
    func fetchTodoDetailByTodoId(for todoId: Int) {
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
    
    func deleteTodoByTodoId(for todoId: Int) {
        MyTodoNetworkManager.MyTodoApi.deleteMyTodo(todoId: todoId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
                print("삭제 실패")
            }
        }
    }
    
    func updateTodoByTodoId(for todoId: Int){
        var title = ""
        var content = ""

        DispatchQueue.main.async {
            title = self.myTodoTitle.text ?? ""
            content = self.myTodoContent.text ?? ""

            guard !title.isEmpty,
                  !content.isEmpty,
                  let dateComponents = self.myTodoDetail?.todoDate,
                  let categoryId = self.selectedCategory?.id else {
                let alert = UIAlertController(title: "경고", message: "내용이 변경되지 않았습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            let updateTodo = MyTodoUpdate(todoId: todoId, categoryId: categoryId, todoTitle: title, todoContent: content, todoDate: dateComponents, todoDone: self.todoDoneCheckBox.isChecked)

            MyTodoNetworkManager.MyTodoApi.updateMyTodo(MyTodoUpdate: updateTodo) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        let alert = UIAlertController(title: "수정 성공", message: "할 일이 수정되었습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    case .failure(_):
                        let alert = UIAlertController(title: "수정 실패", message: "할 일 수정에 실패했습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
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
    MyTodoDetailController(todoId: 1) // 임의의 id 값으로 초기화
}
