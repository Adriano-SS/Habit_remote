//
//  SignInViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    
    @Published var uiState: SignInUIState = .none
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init() {
        cancellable = publisher.sink { value in
            if value {
                print("\(value)")
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .error("Usuario ou senha incorreta!")
            //self.uiState = .goToHomeScreen
        }
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
