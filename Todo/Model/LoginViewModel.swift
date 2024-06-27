import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginSuccessful: Bool = false
    @Published var errorMessage: String?
    @Published var token: String? //**

    private var cancellables = Set<AnyCancellable>()

    func postLogin() {
        AuthService.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == .badServerResponse {
                        self.errorMessage = "서버 응답이 올바르지 않습니다."
                    } else if (error as NSError).code == 400 {
                        self.errorMessage = (error as NSError).localizedDescription
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { loginResponse in //**
                self.token = loginResponse.token //**
                self.isLoginSuccessful = true //**
            })
            .store(in: &cancellables)
    }
}
