import UIKit
import Alamofire
import Combine

class MyPageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, MyInfoEditViewControllerDelegate {

    // UIImagePickerController 인스턴스 생성
    let imagePicker = UIImagePickerController()

    // IBOutlet 변수들 선언
    @IBOutlet weak var NickName: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var AccountTypeLabel: UILabel!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var RefreshButton: UIButton!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI 초기 설정
        setupUI()
        // 사용자 정보 가져오기
        fetchUserInfo()

        // UIImagePickerController 설정
        self.imagePicker.sourceType = .photoLibrary // 사진 앨범에서 가져오기
        self.imagePicker.allowsEditing = true // 사진 편집 가능
        self.imagePicker.delegate = self // delegate 설정

        // 이미지 뷰에 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        ProfileImage.addGestureRecognizer(tapGesture)
        ProfileImage.isUserInteractionEnabled = true

        // ProfileImage의 contentMode 설정
        ProfileImage.contentMode = .scaleAspectFill
        ProfileImage.clipsToBounds = true

        // RefreshButton 액션 연결
            RefreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }

    @IBAction func refreshButtonTapped(_ sender: Any) {
        fetchUserInfo()
    }

    func didUpdateUserInfo() {
        print("User info updated")
        fetchUserInfo()
    }

    // 이미지 선택 화면 표시
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
    }

    // 로그아웃 버튼 액션
    @IBAction func LogOut(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃 완료!", message: nil, preferredStyle: .alert)
        let Ok = UIAlertAction(title: "확인", style: .default) { (action) in
            self.goHome()
        }
        alert.addAction(Ok)
        self.present(alert, animated: true)
    }

    private func setupUI() {
        // 초기 UI 설정 코드
    }

    private func goHome() {
        // 스토리보드 인스턴스화
        let storyboard = UIStoryboard(name: "Login", bundle: nil)

        // LoginTabBarController 인스턴스화
        if let loginTabBarController = storyboard.instantiateViewController(withIdentifier: "LoginTabBarController") as? UITabBarController {
            // LoginTabBarController를 표시
            loginTabBarController.modalPresentationStyle = .fullScreen
            self.present(loginTabBarController, animated: true, completion: nil)
        } else {
            print("LoginTabBarController could not be instantiated")
        }
    }

    private func fetchUserInfo() {
        // 사용자 토큰 가져오기
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("No token found")
            return
        }
        
        // HTTP 헤더 설정
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        // 사용자 정보 요청
        AF.request("http://34.121.86.244:80/users/me", headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON String: \(jsonString)")
                    }
                    do {
                        // 사용자 정보 디코딩
                        let userInfo = try JSONDecoder().decode(UserInfoResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.NickName.text = userInfo.nickname
                            self.EmailLabel.text = userInfo.email
                            self.AccountTypeLabel.text = userInfo.userPublicScope ? "🔓공개 계정" : "🔒비공개 계정"
                            if let profileImageUrl = userInfo.image {
                                self.loadImage(from: profileImageUrl)
                            } else {
                                self.ProfileImage.image = UIImage(named: "profileMain") // 기본 이미지 설정
                            }
                        }
                        self.saveUserInfo(userInfo)
                    } catch {
                        print("Decoding error: \(error)")
                    }
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }
    }


    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let fixedSize = CGSize(width: 294, height: 200)
                        let resizedImage = self.resizeImage(image: image, targetSize: fixedSize)
                        self.ProfileImage.image = resizedImage
                    }
                }
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
    }

    private func saveUserInfo(_ userInfo: UserInfoResponse) {
        UserDefaults.standard.set(userInfo.nickname, forKey: "nickname")
        UserDefaults.standard.set(userInfo.email, forKey: "email")
        UserDefaults.standard.set(userInfo.userPublicScope, forKey: "userPublicScope")
        if let profileImageUrl = userInfo.image {
            UserDefaults.standard.set(profileImageUrl, forKey: "profileImageUrl")
        }
        UserDefaults.standard.synchronize()
    }

    func showEditViewController() {
        let editViewController = MyInfoEditViewController()
        editViewController.delegate = self
        present(editViewController, animated: true, completion: nil)
    }
}

// UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension MyPageViewController {

    func uploadImage(image: UIImage) {
        // UserDefaults에서 저장된 토큰을 가져옵니다.
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            // 토큰이 없을 경우 오류 메시지를 출력합니다.
            print("토큰을 찾을 수 없습니다")
            return
        }

        // HTTP 헤더를 설정합니다. Authorization 헤더에 Bearer 토큰을 추가하고, Content-type을 multipart/form-data로 설정합니다.
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-type": "multipart/form-data"
        ]

        // 업로드할 URL을 설정합니다.
        let url = "http://34.121.86.244:80/users/me"

        // Alamofire를 사용하여 이미지 데이터를 multipart/form-data 형식으로 업로드합니다.
        AF.upload(multipartFormData: { multipartFormData in
            // 이미지 데이터를 JPEG 포맷으로 압축하여 생성합니다. 압축 품질은 0.5로 설정합니다.
            if let imageData = image.jpegData(compressionQuality: 0.5) {
                // 생성된 이미지 데이터를 multipart form data에 추가합니다. 필드 이름은 "image", 파일 이름은 "profile.jpg", MIME 타입은 "image/jpeg"로 설정합니다.
                multipartFormData.append(imageData, withName: "image", fileName: "profile.jpg", mimeType: "image/jpeg")
            }
        },
        // 여기서 HTTP 메서드를 POST에서 PUT으로 변경합니다.
        to: url,
        method: .put, // HTTP 메서드를 PUT으로 설정합니다.
        headers: headers).responseJSON { response in
            // 응답 전체를 디버깅 출력
            debugPrint(response)

            // 서버 응답을 처리합니다.
            switch response.result {
            case .success(let value):
                // 응답이 성공적일 경우, JSON 데이터를 파싱하여 이미지 URL을 가져옵니다.
                if let json = value as? [String: Any], let imageUrl = json["image"] as? String {
                    // 이미지 URL을 UserDefaults에 저장합니다.
                    UserDefaults.standard.set(imageUrl, forKey: "profileImageUrl")
                    UserDefaults.standard.synchronize()
                    print("Image uploaded successfully, URL: \(imageUrl)")
                } else {
                    // JSON 파싱 실패 시 오류 메시지를 출력합니다.
                    print("Response JSON parsing failed")
                }
            case .failure(let error):
                // 업로드가 실패할 경우 오류 메시지를 출력합니다.
                print("Image upload failed: \(error)")
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }

        if let newImage = newImage {
            let fixedSize = CGSize(width: 294, height: 200)
            let resizedImage = resizeImage(image: newImage, targetSize: fixedSize)
            self.ProfileImage.image = resizedImage
            uploadImage(image: resizedImage) // 이미지 업로드 호출
        }

        picker.dismiss(animated: true, completion: nil)
    }

    // 이미지 리사이징 함수
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // 가장 적은 비율로 스케일링
        let scaleFactor = min(widthRatio, heightRatio)

        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

        // 이미지 리사이징
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }

        return scaledImage
    }
}
