import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var nickname: String = ""
    @Published var userPublicScope: Bool = false
    @Published var isSignUpSuccessful: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func postSignup() {
        AuthService.signup(email: email, password: password, passwordCheck: passwordCheck, nickname: nickname, userPublicScope: userPublicScope)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == .badServerResponse {
                        self.errorMessage = "서버 응답이 올바르지 않습니다."
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { isSuccess in
                self.isSignUpSuccessful = isSuccess
            })
            .store(in: &cancellables)
    }
}
