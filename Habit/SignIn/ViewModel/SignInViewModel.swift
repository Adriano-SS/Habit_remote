//
//  SignInViewModel.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    //A estrutura do Combine sempre é do tipo <sucesso, erro>
    private let publisher = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        cancellable = publisher.sink { value in
            if value {
                print("Usuário criado! goToHome: \(value)")
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    //Utilizando URLEncoded
    func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email,
                                                                          password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                //Blocos para ERRO ou FINISHED
                switch(completion) {
                case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                //Bloco para SUCESSO
                let auth = UserAuth(idToken: success.accessToken,
                                    refreshToken: success.refreshToken,
                                    expires: success.expires,
                                    tokenType: success.tokenType)
                self.interactor.insertUser(userAuth: auth)
                
                self.uiState = .goToHomeScreen
            }

        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .error("Usuario ou senha incorreta!")
            //self.uiState = .goToHomeScreen
        }*/
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
