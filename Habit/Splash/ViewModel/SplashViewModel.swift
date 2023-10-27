//
//  SplashViewModel.swift
//  Habit
//
//  Created by Adriano on 9/20/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    
    private var cancellableAuth: AnyCancellable?
    
    private let interactor: SplashInteractor
        
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
    }
    
    func onApperar(){
        self.uiState = .loading
        cancellableAuth = interactor.fecthAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires)) {
                    //chamar refreshToken na API
                    print("Token Expirou")
                }
                else {
                    self.uiState = .goToHomeScreen
                }
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
    
    

