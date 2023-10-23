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
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
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
    //Utilizando URLEncoded
    func login() {
        self.uiState = .loading
        interactor.login(loginRequest: SignInRequest(email: email,
                                                password: password)) { (successResponse, errorResponse) in
            if let error = errorResponse {
                //Operação de segundo plano é despachada para execução principal da View.
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
                }
            }
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
    
    /*func itSelfView() -> some View {
        return SignInViewRouter.makeItSelf()
    }*/
    
}
