import UIKit
import Alamofire
import Combine

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var NickName: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var AccountTypeLabel: UILabel!
    @IBOutlet weak var LogoutButton: UIButton!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchUserInfo() //**
    }
    
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
    
    private func fetchUserInfo() { //**
        guard let token = UserDefaults.standard.string(forKey: "token") else { //**
            print("No token found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)" //**
        ]
        
        AF.request("http://34.69.5.209:30008/users/me", headers: headers) // 올바른 API URL 사용 //**
            .validate() // 응답 검증 추가 //**
            .responseData { response in // 응답 데이터를 로깅하기 위해 responseData 사용 //**
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON String: \(jsonString)")
                    }
                    do {
                        let userInfo = try JSONDecoder().decode(UserInfoResponse.self, from: data)
                        self.NickName.text = userInfo.nickname
                        self.EmailLabel.text = userInfo.email
                        self.AccountTypeLabel.text = userInfo.userPublicScope ? "🔓공개 계정" : "🔒비공개 계정"
                    } catch {
                        print("Decoding error: \(error)")
                    }
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }
    }
}
