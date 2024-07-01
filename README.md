# 📝 친구와 일정을 공유할 수 있는 TO-DO List✨

![KakaoTalk_Photo_2024-06-26-01-36-04](https://github.com/encore-full-stack-5/IOS_TODO_FE/assets/163789199/eba38135-2036-4c61-9c47-8db5a1ed3ce8)

<br>

## 📌 프로젝트 소개

- You & I ToDo는 원하는 날짜에 계획을 세울 수 있습니다.
- 각 회원은 친구를 검색하여 친구를 추가할 수 있고 추가된 친구들과 계획을 공유할 수 있습니다.
- 각자 추가한 일정에 서로 댓글을 달 수 있습니다.
- 각 회원은 계획을 세울 때 카테고리를 지정하여 설정할 수 있습니다.
- 로그인, 회원가입, 로그아웃, 일정생성, 일정공유, 카테고리추가, 친구추가, 친구요청관리, 친구검색, 친구목록,
   회원탈퇴, 계정 공개여부 설정 기능이 구현되어 있습니다.
- IOS와 Web을 지원합니다.
  
<br>

## 🧑‍🤝‍🧑 팀원 구성

| **김재윤** | **안홍범** |
| :------: | :------: |
| [<img src="https://github.com/encore-full-stack-5/IOS_TODO_FE/assets/163789199/c489e86c-a343-41ae-9255-d9e4b7c1598e" height="150" width="150">](https://github.com/jaeyoon00) <br/> @jaeyoon00 | [<img src="https://github.com/encore-full-stack-5/IOS_TODO_FE/assets/163789199/27a0413c-d3a0-4254-8cfc-feb0c874b665" height="150" width="150">](https://github.com/son7877) <br/> @son7877 |


<br>

## 1️⃣ 개발 환경

- Front : IOS(Swift)
- Back-end : 깃 주소 달기
- 버전 및 이슈관리 : Github
- 협업 툴 : Notion, Github, Google Sheets(WBS)
- 서버 통신 방법 : Alamofire
- 일정 관리 : [Google Sheets WBS](https://docs.google.com/spreadsheets/d/1CCqvga7DqJ_iyfcbldKJ72Xd_osNgHZfpzMe6PtB6O4/edit?gid=1235928492#gid=1235928492),
            [SCRUM](https://whispering-foxtail-e30.notion.site/SCRUM-bc636614392548029802d18d682a6d8e)
- 디자인 : [Figma](https://www.figma.com/design/QkBCgoj4Ilui4hu06K8vrK/ToDOList?node-id=0-1&t=Pu3VSKno53b170sl-1)
<br>

## 2️⃣ 채택한 기술 스택, 라이브러리

### UiKit, SwiftUI, Alamofire, TagListView, SimpleCheckBox

## 3️⃣ 프로젝트 구조 
.
├── AppDelegate.swift
├── Info.plist
├── LaunchScreenController.swift
├── SceneDelegate.swift
├── component
│   ├── CommentRow.swift
│   ├── FriendCellTableViewCell.swift
│   ├── MyFriendTodoCell.swift
│   ├── MyFriendViewCell.swift
│   └── RequestViewCell.swift
├── extension
│   ├── TagListView
│   │   ├── MyTodoDetailController_TagListView.swift
│   │   └── MyTodoEnrollController_TagListViewDelegate.swift
│   ├── UICalendarView
│   │   ├── MyFriendsTodoController_UICalendarSelection.swift
│   │   ├── MyFriendsTodoController_UICalendarView.swift
│   │   └── MyTodoViewController_UICalendar.swift
│   ├── UICollectionView
│   │   └── MyFriendsTodoController_UICollectionView.swift
│   └── UITableView
│       ├── MyFriendsTodoController_UITableView.swift
│       └── MyTodoViewController_UITableView.swift
├── model
│   ├── entity
│   │   ├── Comment.swift
│   │   ├── Friends.swift
│   │   ├── MyTodo.swift
│   │   └── Users.swift
│   └── viewModel
│       ├── LoginViewModel.swift
│       └── SignUpViewModel.swift
├── network
│   ├── Config.swift
│   ├── api
│   │   ├── AuthApi.swift
│   │   ├── CommentsApi.swift
│   │   ├── FriendsApi.swift
│   │   ├── FriendsTodoApi.swift
│   │   └── MyTodoApi.swift
│   └── dto
│       ├── LoginResponse.swift
│       ├── SignUpResponse.swift
│       ├── UserInfoEditRequest.swift
│       └── UserInfoResponse.swift
├── storyBoard
│   ├── Base.lproj
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── FriendManagement.storyboard
│   ├── FriendManagement_addFriend.storyboard
│   ├── FriendManagement_myFriends.storyboard
│   ├── FriendManagement_requests.storyboard
│   ├── Login.storyboard
│   ├── MyFriendsTodo.storyboard
│   ├── MyInfoEdit.storyboard
│   ├── MyPage.storyboard
│   ├── MyTodoEnroll.storyboard
│   └── SignUp.storyboard
├── storyboard_jaeyoon
│   └── Start.storyboard
└── viewController
    ├── LoadingViewController.swift
    ├── MainViewController.swift
    ├── StartController.swift
    ├── auth
    │   ├── LogInTabBarController.swift
    │   ├── LoginViewController.swift
    │   ├── PasswordEditViewController.swift
    │   └── SignUpViewController.swift
    ├── friendManagement
    │   ├── AddFriendViewController.swift
    │   ├── FriendManagementTabBarController.swift
    │   ├── FriendsManager.swift
    │   ├── MyFriendsViewController.swift
    │   └── RequestViewController.swift
    ├── myInfo
    │   ├── MyInfoEditViewController.swift
    │   └── MyPageViewController.swift
    └── todo
        ├── MyFriendsTodoController.swift
        ├── MyFriendsTodoDetailController.swift
        ├── MyTodoDetailController.swift
        ├── MyTodoEnrollController.swift
        └── MyTodoViewController.swift

<br>

## 4️⃣ 역할 분담

### 👽 안홍범

- **UI**
    - 내 Todo View, 내 친구 Todo View
- **기능**
    - 내 Todo(조회,등록,수정,삭제), 내 친구 Todo 조회, 댓글 기능, 친구 요청 및 등록, 유저 검색

<br>
    
### 👻 김재윤

- **UI**
    - 페이지 : 인트로 View, 로그인 및 회원가입 View , 내 정보조회 View, 친구관리 View
- **기능**
    - 로그인 및 회원 가입, 프로필 이미지 설정, 내 정보 수정(닉네임, 비밀번호, 공개 여부)

<br>

## 5️⃣ 개발 기간 및 작업관리

### 개발 기간
- 전체 개발 기간 : 2024-05-20 ~ 2024-07-01
- Swift공부 및 기술 채택 : 2024-05-20 ~ 2024-06-02
- UI 구현 및 기능 구현 : 2024-06-03 ~ 2024-06-24
- 서버 통신 : 2024-06-25 ~ 2024-07-01

<br>

## 6️⃣ 페이지별 기능

<br>

## 7️⃣ 트러블 슈팅

- [내 정보 수정 통신 이슈](https://github.com/encore-full-stack-5/IOS_TODO_FE/wiki/README-6.트러블-슈팅_내-정보-수정-통신-이슈)


<br>

## 8️⃣ 개선 목표
 - E-mail과 QR코드를 활용한 비밀번호 찾기 구현
 - 캘린더에 todo가 등록되어 있는 날짜에 구분 표시 추가

<br>

## 9️⃣ 프로젝트 느낀점

### 👀 안홍범


### ✨ 김재윤
금번 프로젝트는 IOS 개발을 처음 접하고 Swift와 Xcode로 코딩하는 모든 것들이 처음 접해보는 프로젝트였다 <br>
문법공부부터 어플 완성까지 한달이라는 시간이 걸렸지만 IOS개발에 더 흥미를 가지고 제대로 공부해보고 싶은 생각이 드는 프로젝트였다<br>
시간이 생각보다 촉박해서 구현하는데 집중을 했다보니 세부적으로 구조를 이해하거나 문법을 익히는게 제대로 되지 않은 것 같은 느낌이라 아쉬웠고 <br>
다음 프로젝트에서는 확실히 알고 구현해낼 수 있도록 더 공부해야겠다

