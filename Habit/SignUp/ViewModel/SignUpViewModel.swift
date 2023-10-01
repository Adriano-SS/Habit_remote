//
//  SignUpViewModel.swift
//  Habit
//
//  Created by user246507 on 9/20/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var document: String = ""
    @Published var phone: String = ""
    @Published var birthday: String = ""
    @Published var gender: Gender = .male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    func signUp() {
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
