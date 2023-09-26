//
//  SignInViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI		

class SignInViewModel: ObservableObject {
    
    @Published var uiState: SignInUIState = .none
    
    func login(email: String, password: String) {
        uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //self.uiState = .error("Usuario ou senha incorreta!")
            self.uiState = .goToHomeScreen
        }
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
}
