import UIKit
import SwiftUI
import SimpleCheckbox
import TagListView

class FriendsTodoDetailController: UIViewController {

    var todoId: Int
    var todoDetail: FriendsTodoDetail?

    let todoTitle = UILabel()
    let todoContent = UILabel()
    let todoDate = UILabel()
    let todoComplete = UILabel()
    let todoCheckbox = Checkbox()
    let category = TagListView()
    let commentLabel = UILabel()
    let todoComment = UITextField()
    let commentButton = UIButton()
    var comments: [String] = [] // Example comments

    var categoryList: [String] = ["운동", "공부", "취미", "기타"]

    // Custom initializer
    init(todoId: Int) {
        self.todoId = todoId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        fetchTodoDetail()
    }

    func setupViews() {
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        todoContent.translatesAutoresizingMaskIntoConstraints = false
        todoContent.numberOfLines = 0
        
        todoDate.translatesAutoresizingMaskIntoConstraints = false
        todoDate.font = .systemFont(ofSize: 14)
        todoDate.textColor = .gray
        
        todoComplete.translatesAutoresizingMaskIntoConstraints = false
        todoComplete.text = "완료 여부"
        
        todoCheckbox.translatesAutoresizingMaskIntoConstraints = false
        todoCheckbox.borderStyle = .circle
        todoCheckbox.checkedBorderColor = .systemPink.withAlphaComponent(0.5)
        todoCheckbox.uncheckedBorderColor = .systemPink.withAlphaComponent(0.5)
        todoCheckbox.checkmarkColor = .systemPink.withAlphaComponent(0.7)
        todoCheckbox.checkmarkStyle = .tick
        
        category.alignment = .left
        category.textFont = .systemFont(ofSize: 15)
        category.cornerRadius = 10
        category.paddingX = 10
        category.paddingY = 5
        category.marginX = 5
        category.marginY = 5
        category.tagBackgroundColor = .systemPink.withAlphaComponent(0.6)
        category.translatesAutoresizingMaskIntoConstraints = false
       
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.text = "댓글"
        commentLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        todoComment.translatesAutoresizingMaskIntoConstraints = false
        todoComment.placeholder = "댓글 내용을 입력해 주세요."
        todoComment.borderStyle = .roundedRect
        todoComment.tintColor = .systemPink.withAlphaComponent(0.6)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.setTitle("등록", for: .normal)
        commentButton.setTitleColor(.systemPink.withAlphaComponent(0.6), for: .normal)
        commentButton.backgroundColor = .systemPink.withAlphaComponent(0.1)
        commentButton.layer.cornerRadius = 5
        commentButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        
        view.addSubview(todoDate)
        view.addSubview(todoTitle)
        view.addSubview(todoContent)
        view.addSubview(todoComplete)
        view.addSubview(todoCheckbox)
        view.addSubview(category)
        view.addSubview(commentLabel)
        view.addSubview(todoComment)
        view.addSubview(commentButton)
        
        // Add SwiftUI comments list
        let commentList = List(comments, id: \.self) { comment in
            CommentRow()
        }
        .scrollContentBackground(.hidden)
        .background(Color.pink.opacity(0.1))
        .cornerRadius(15)
        
        let hostingController = UIHostingController(rootView: commentList)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            todoDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todoDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            todoTitle.topAnchor.constraint(equalTo: todoDate.bottomAnchor, constant: 20),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            category.leadingAnchor.constraint(equalTo: todoTitle.trailingAnchor, constant: 10),
            category.centerYAnchor.constraint(equalTo: todoTitle.centerYAnchor),
            category.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            category.widthAnchor.constraint(greaterThanOrEqualToConstant: 100), // Ensure category has some width
            
            todoContent.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 20),
            todoContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todoComplete.topAnchor.constraint(equalTo: todoContent.bottomAnchor, constant: 40),
            todoComplete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            todoCheckbox.centerYAnchor.constraint(equalTo: todoComplete.centerYAnchor),
            todoCheckbox.leadingAnchor.constraint(equalTo: todoComplete.trailingAnchor, constant: 10),
            todoCheckbox.widthAnchor.constraint(equalToConstant: 25),
            todoCheckbox.heightAnchor.constraint(equalToConstant: 25),
            
            commentLabel.topAnchor.constraint(equalTo: todoComplete.bottomAnchor, constant: 40),
            commentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: todoComment.topAnchor, constant: -20),
            hostingController.view.heightAnchor.constraint(equalToConstant: 390),
            
            todoComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoComment.trailingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: -10),
            todoComment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            commentButton.centerYAnchor.constraint(equalTo: todoComment.centerYAnchor),
            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentButton.widthAnchor.constraint(equalToConstant: 60),
            commentButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func fetchTodoDetail() {
        FriendsTodoNetworkManager.FriendsTodoApi.getTodoDetail(todoId: todoId) { result in
            switch result {
            case .success(let todoDetail):
                self.todoDetail = todoDetail
                self.updateUI(with: todoDetail)
            case .failure(let error):
                print("Failed to fetch todo details: \(error)")
            }
        }
    }

    func updateUI(with detail: FriendsTodoDetail) {
        todoTitle.text = detail.todoTitle
        todoContent.text = detail.todoContent
        todoDate.text = detail.todoDate
        todoCheckbox.isChecked = detail.todoDone
        
        category.removeAllTags()
        category.addTag(categoryList[detail.categoryId])
    }

    @objc func addComment() {
        print("댓글 추가")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}



#Preview {
    FriendsTodoDetailController(todoId: 1)
}
