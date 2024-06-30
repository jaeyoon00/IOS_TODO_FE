import UIKit
import Foundation
import SimpleCheckbox
import Alamofire
import TagListView
import SwiftUI

class MyTodoDetailController: UIViewController {
    
    var myTodoDetail: MyTodoDetail?
    var myTodoUpdate: MyTodoUpdate?
    var todoId: Int?
    var selectedCategory: (id: Int, name: String)?
    
    var comments: [Comment] = []
    
    private var myTodoTitle: UITextField!
    private var myTodoContent: UITextField!
    private var todoDoneCheckBox: Checkbox!
    private var categoryTagListView: TagListView!
    
    // 커스텀 초기화 메소드
    init(todoId: Int) {
        self.todoId = todoId
        super.init(nibName: nil, bundle: nil)
    }
    
    // 필수 초기화 메소드 구현
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰 로드 시 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchTodoDetailByTodoId(for: todoId!)
        fetchMyTodoComments(for: todoId!)
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
        
        categoryTagListView = TagListView()
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
        
        
        
        
        // MARK: - Constraints 설정
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
            categoryTagListView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func reloadCommentList(){
        if (comments.count == 0) {
            let noCommentLabel = UILabel()
            noCommentLabel.translatesAutoresizingMaskIntoConstraints = false
            noCommentLabel.text = "친구의 댓글이 없습니다."
            noCommentLabel.font = .systemFont(ofSize: 15, weight: .thin)
            noCommentLabel.textColor = .black.withAlphaComponent(0.8)
            noCommentLabel.textAlignment = .center
            
            view.addSubview(noCommentLabel)
            
            NSLayoutConstraint.activate([
                noCommentLabel.topAnchor.constraint(equalTo: categoryTagListView.bottomAnchor, constant: 10),
                noCommentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                noCommentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                noCommentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
            ])
        }
        else {
            let commentList = List {
                Section(header: Text("댓글")+Text(" \(comments.count)")) {
                    ForEach(comments, id: \.id) { [self] comment in
                        MytodoCommentRow(comment: comment)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background {
                Color.pink.opacity(0.1)
            }
            .cornerRadius(15)
            
            let commentListController = UIHostingController(rootView: commentList)
            addChild(commentListController)
            commentListController.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(commentListController.view)
            
            // Update constraints for the new comment list view
            NSLayoutConstraint.activate([
                commentListController.view.topAnchor.constraint(equalTo: categoryTagListView.bottomAnchor, constant: 10),
                commentListController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                commentListController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                commentListController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
            ])
        }
        
    }
    
    func MytodoCommentRow(comment: Comment) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 5) {
//                    Text(comment.nickname!)
//                        .font(.system(size: 15, weight: .bold))
                    Text(comment.content)
                        .font(.system(size: 12, weight: .light))
                }
            }
            Text(formattedDate(from: comment.createdAt))
                .font(.system(size: 10, weight: .thin))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 0)
    }
    
    func formattedDate(from dateArray: [Int]) -> String {
        guard dateArray.count == 6 else { return "Invalid date" }
        
        var dateComponents = DateComponents()
        dateComponents.year = dateArray[0]
        dateComponents.month = dateArray[1]
        dateComponents.day = dateArray[2]
        dateComponents.hour = dateArray[3]
        dateComponents.minute = dateArray[4]
        dateComponents.second = dateArray[5]
        
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        
        return "Invalid date"
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
    
    func fetchMyTodoComments(for todoId: Int) {
        CommentNetworkManager.CommentApi.getCommentList(todoId: todoId) { result in
            switch result {
            case .success(let comments):
                self.comments = comments
                DispatchQueue.main.async {
                    self.reloadCommentList()
                }
            case .failure(let error):
                print(error)
            }
        }
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
    
    func updateTodoByTodoId(for todoId: Int) {
        guard let initialTodoDetail = myTodoDetail else { return }
        
        DispatchQueue.main.async {
            let newTitle = self.myTodoTitle.text ?? ""
            let newContent = self.myTodoContent.text ?? ""
            let newCategoryId = self.selectedCategory?.id ?? initialTodoDetail.categoryId
            let newTodoDone = self.todoDoneCheckBox.isChecked
            
            // Check if any field has changed
            let hasChanges = newTitle != initialTodoDetail.todoTitle ||
                             newContent != initialTodoDetail.todoContent ||
                             newCategoryId != initialTodoDetail.categoryId ||
                             newTodoDone != initialTodoDetail.todoDone
            
            if !hasChanges {
                let alert = UIAlertController(title: "경고", message: "내용이 변경되지 않았습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            let updatedTodo = MyTodoUpdate(todoId: todoId,
                                           categoryId: newCategoryId,
                                           todoTitle: newTitle,
                                           todoContent: newContent,
                                           todoDate: initialTodoDetail.todoDate,
                                           todoDone: newTodoDone)

            MyTodoNetworkManager.MyTodoApi.updateMyTodo(MyTodoUpdate: updatedTodo) { result in
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


