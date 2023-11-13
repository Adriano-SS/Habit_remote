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
    let viewModel = HomeViewModel()
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
        
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onApperar(){
        self.uiState = .loading
        cancellableAuth = interactor.fecthAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > userAuth!.expires) {
                    //chamar refreshToken na API
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires:
                                                    Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            self.interactor.insertUser(userAuth: auth)
                            self.uiState = .goToHomeScreen
                        })
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
        return SplashViewRouter.makeHomeView(viewModel: viewModel)
    }
}
