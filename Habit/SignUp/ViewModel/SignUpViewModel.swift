//
//  SignUpViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .loading
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    func signUp(fullName: String, email: String, password: String, document: String, phone: String, gender: Gender) {
        uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.uiState = .error("Usuario ja existe!")
            self.uiState = .sucess
            self.publisher.send(true)
        }
    }}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
