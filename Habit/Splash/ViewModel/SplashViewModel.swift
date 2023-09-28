//
//  SplashViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI
class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    func onApperar(){
        uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //self.uiState = .error("Perda de conexao com o servidor")
            //self.uiState = .goToHomeScreen
            self.uiState = .goToSignInScreen
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}

/*extension SplashViewModel{
    func signUpView() -> some View {
        return SplashViewRouter.makeSignUpView()
    }
}*/
    
    

