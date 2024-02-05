//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    private let interactor: SignUpInteractor
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthday: String = ""
    @Published var gender: Gender = .male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    
    init(intercator: SignUpInteractor) {
        self.interactor = intercator
    }
    
    deinit{
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    //Utilizou-se JSON Aplication
    func signUp() {
        self.uiState = .loading
        
        //Converte String do usuário para formato de data
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted  = formatter.date(from: birthday)
        
        //valida a entrada de usuario
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        //converte para formato String americano esperado pelo servidor
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        cancellableSignUp = interactor.postUser(signUpRequest: SignUpRequest(fullname: fullName,
                                                         email: email,
                                                         document: document,
                                                         phone: phone,
                                                         gender: gender.index,
                                                         birthday: birthday,
                                                         password: password))
        .receive(on: DispatchQueue.main)
        .sink { completion in
            //error | finished
            switch(completion) {
            case .failure(let appError):
                self.uiState = .error(appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { created in
            if created {
                self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch(completion) {
                    case .failure(_):
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { success in
                    print(created)
                    
                    let auth = UserAuth(idToken: success.accessToken,
                                        refreshToken: success.refreshToken,
                                        expires:
                                            Date().timeIntervalSince1970 + Double(success.expires),
                                        tokenType: success.tokenType)
                    self.interactor.insertUser(userAuth: auth)
                    
                    self.publisher.send(created)
                    self.uiState = .success
                }
            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

